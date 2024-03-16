// ignore_for_file: prefer_const_constructors

import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/calender_picker.dart';
import 'package:voyager/components/date_section.dart';
import 'package:voyager/pages/booking_sections/search_trains.dart';
import 'package:voyager/utils/constants.dart';

class TrainSearch extends StatefulWidget {
  TrainSearch({super.key});

  @override
  State<TrainSearch> createState() => _TrainSearchState();
}

class _TrainSearchState extends State<TrainSearch> {
  TextEditingController fromStationcontroller = TextEditingController();

  TextEditingController toStationcontroller = TextEditingController();

  DateTime? selectedDate = DateTime.now();
  List<String> selectedStrings = [];

  void toggleSelection(String string) {
    setState(() {
      if (selectedStrings.contains(string)) {
        selectedStrings.remove(string);
      } else {
        selectedStrings.add(string);
      }
    });
  }

  void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _themeProvider = Provider.of<ThemeProvider>(context);
        return SizedBox(
          height: 300,
          child: AlertDialog(
            backgroundColor: _themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            surfaceTintColor: _themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    selectedDate = null;
                  });
                },
                child: Text('Clear'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Select'),
              ),
            ],
            content: DatePicker(
              onDateSelected: (date) {
                setState(() {
                  selectedDate = date;
                  print(selectedDate.toString());
                });
              },
            ),
          ),
        );
      },
    );
  }

  bool isListViewVisibleForDeparture = false;
  bool isListViewVisibleForArrival = false;
  String? selectedFromStation = null;
  String? selectedToStation = null;

  List<Map<String, String>> getFilteredStations(String searchText) {
    return Stations.where((station) {
      final String code = station['code'] ?? '';
      final String name = station['name'] ?? '';
      return code.toLowerCase().contains(searchText.toLowerCase()) ||
          name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  double counterCount = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 20, 0, 80),
              child: Text(
                'Search Trains',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 0.95 * screenWidth,
                        child: TextField(
                          controller: fromStationcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.near_me,
                            ),
                            hintText: 'From',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: kGreenColor,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isListViewVisibleForDeparture = true;
                            });
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (isListViewVisibleForDeparture)
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount:
                                getFilteredStations(fromStationcontroller.text)
                                    .length,
                            itemBuilder: (context, index) {
                              final station = getFilteredStations(
                                  fromStationcontroller.text)[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text('${station['code']}'),
                                    SizedBox(width: 5),
                                    Text('${station['name']}')
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    fromStationcontroller.text =
                                        station['name'] ?? '';
                                    selectedFromStation = station['code'];
                                    isListViewVisibleForDeparture = false;
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 0.95 * screenWidth,
                        child: TextField(
                          controller: toStationcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on,
                            ),
                            hintText: 'To',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: kGreenColor,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              isListViewVisibleForArrival = true;
                            });
                          },
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  if (isListViewVisibleForArrival)
                    SizedBox(
                      height: 200,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount:
                                getFilteredStations(toStationcontroller.text)
                                    .length,
                            itemBuilder: (context, index) {
                              final station = getFilteredStations(
                                  toStationcontroller.text)[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    Text('${station['code']}'),
                                    SizedBox(width: 5),
                                    Text('${station['name']}')
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    toStationcontroller.text =
                                        station['name'] ?? '';
                                    selectedToStation = station['code'];
                                    isListViewVisibleForArrival = false;
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 10, 0),
              child: Row(
                children: [
                  Text(
                    'Trip Date',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                  Spacer(),
                  if (selectedDate != null)
                    DateDisplayer(
                        Date: selectedDate!.day.toString(),
                        Day: selectedDate!.weekday,
                        month: selectedDate!.month,
                        Year: selectedDate!.year.toString(),
                        valid: true)
                  else
                    DateDisplayer(
                        Date: 'Month',
                        Day: 0,
                        month: 0,
                        Year: '',
                        valid: false),
                  IconButton(
                    icon: Icon(Icons.calendar_month),
                    onPressed: () {
                      _showDatePickerDialog(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 10, 20),
              child: Row(
                children: [
                  Text(
                    'Passengers',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                  Spacer(),
                  CustomizableCounter(
                    borderWidth: 1,
                    showButtonText: false,
                    count: 1,
                    step: 1,
                    minCount: 1,
                    incrementIcon: Icon(
                      Icons.add,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    decrementIcon: Icon(
                      Icons.remove,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                    onCountChange: (count) {
                      setState(() {
                        counterCount = count;
                      });
                      //counterCount=count;
                    },
                    onIncrement: (count) {},
                    onDecrement: (count) {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {
                  //debugPrint(counterCount.toString());
                  if (selectedFromStation != null &&
                      selectedToStation != null &&
                      selectedDate != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SearchTrains(
                          fromStation: selectedFromStation,
                          toStation: selectedToStation,
                          fromStationName: fromStationcontroller.text,
                          toStationName: toStationcontroller.text,
                          date:
                              '${selectedDate?.year}-${selectedDate?.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}',
                          passengers: counterCount.toInt(),
                        );
                      }),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill all the fields'),
                      ),
                    );
                  }
                },
                child: Text('Search')),
          ],
        ),
      ),
    );
  }
}
