// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/calender_picker.dart';
import 'package:voyager/components/date_section.dart';
import 'package:voyager/pages/search_flights.dart';
import 'package:voyager/utils/constants.dart';

class FlightSearch extends StatefulWidget {
  FlightSearch({super.key});

  @override
  State<FlightSearch> createState() => _FlightSearchState();
}

class _FlightSearchState extends State<FlightSearch> {
  TextEditingController fromAirportcontroller = TextEditingController();

  TextEditingController toAirportcontroller = TextEditingController();
  Map<String, String>? selectedFromAirport;
  Map<String, String>? selectedToAirport;

  DateTime? selectedDepartureDate = DateTime.now();
  DateTime? selectedArrivalDate = null;
  List<String> selectedStrings = [];

  void toggleSelection(String selectedItem) {
    setState(() {
      if (selectedStrings.contains(selectedItem)) {
        selectedStrings
            .remove(selectedItem); // If already selected, deselect it
      } else {
        selectedStrings.clear(); // Clear previously selected items
        selectedStrings.add(selectedItem); // Select the new item
      }
    });
  }

  void _showDatePickerDialog(BuildContext context, bool Arrival) {
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
                    if (Arrival) {
                      selectedArrivalDate = null;
                    } else {
                      selectedDepartureDate = null;
                    }
                  });
                },
                child: Text('Clear'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Select'),
              ),
            ],
            content: DatePicker(
              onDateSelected: (date) {
                setState(() {
                  if (Arrival) {
                    selectedArrivalDate = date;
                  } else {
                    selectedDepartureDate = date;
                  }
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

  List<Map<String, String>> getFilteredAirports(String searchText) {
    return Airports.where((airport) {
      final String code = airport['code'] ?? '';
      final String name = airport['name'] ?? '';
      final String place = airport['place'] ?? '';
      return code.toLowerCase().contains(searchText.toLowerCase()) ||
          name.toLowerCase().contains(searchText.toLowerCase()) ||
          place.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  List<String> stringList = ["ECONOMY", "BUSSINESS", "FIRST CLASS"];

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
                'Search Flights',
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
                          controller: fromAirportcontroller,
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
                                getFilteredAirports(fromAirportcontroller.text)
                                    .length,
                            itemBuilder: (context, index) {
                              final airport = getFilteredAirports(
                                  fromAirportcontroller.text)[index];
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 0.95 * screenWidth),
                                child: ListTile(
                                  title: SizedBox(
                                    width: 0.95 * screenWidth,
                                    child: Row(
                                      children: [
                                        Text('${airport['code']}'),
                                        SizedBox(width: 5),
                                        ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: 0.75 * screenWidth),
                                            child: Text(
                                              '${airport['name']}',
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      fromAirportcontroller.text =
                                          airport['name'] ?? '';
                                      isListViewVisibleForDeparture = false;
                                      selectedFromAirport = airport;
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    });
                                  },
                                ),
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
                          controller: toAirportcontroller,
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
                                getFilteredAirports(toAirportcontroller.text)
                                    .length,
                            itemBuilder: (context, index) {
                              final airport = getFilteredAirports(
                                  toAirportcontroller.text)[index];
                              return ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 0.95 * screenWidth),
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      Text('${airport['code']}'),
                                      SizedBox(width: 5),
                                      ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: 0.75 * screenWidth),
                                          child: Text(
                                            '${airport['name']}',
                                            overflow: TextOverflow.ellipsis,
                                          ))
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      toAirportcontroller.text =
                                          airport['name'] ?? '';
                                      selectedToAirport = airport;
                                      // print(selectedToAirport.toString());
                                      isListViewVisibleForArrival = false;
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8, 0, 0),
                      child: Text(
                        'Departure',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 4, 8, 8),
                      child: Row(
                        children: [
                          if (selectedDepartureDate != null)
                            DateDisplayer(
                                Date: selectedDepartureDate!.day.toString(),
                                Day: selectedDepartureDate!.weekday,
                                month: selectedDepartureDate!.month,
                                Year: selectedDepartureDate!.year.toString(),
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
                              _showDatePickerDialog(context, false);
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 40.0, 4),
                      child: Text(
                        'Arrival',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontFamily: 'ProductSans',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        if (selectedArrivalDate != null)
                          DateDisplayer(
                              Date: selectedArrivalDate!.day.toString(),
                              Day: selectedArrivalDate!.weekday,
                              month: selectedArrivalDate!.month,
                              Year: selectedArrivalDate!.year.toString(),
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
                            _showDatePickerDialog(context, true);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
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
            SizedBox(
              height: 60,
              width: screenWidth,
              child: ListView.builder(
                itemCount: stringList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  bool isSelected = selectedStrings.contains(stringList[index]);
                  return SizedBox(
                    width: screenWidth / 3,
                    child: GestureDetector(
                      onTap: () {
                        toggleSelection(stringList[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.51),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? kGreenColor : Colors.grey[800],
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              stringList[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchFlights(
                                selectedFromAirport: selectedFromAirport,
                                selectedToAirport: selectedToAirport,
                                DepartureDate:
                                    '${selectedDepartureDate?.year}-${selectedDepartureDate?.month.toString().padLeft(2, '0')}-${selectedDepartureDate!.day.toString().padLeft(2, '0')}',
                                Class: selectedStrings.isNotEmpty
                                    ? selectedStrings[0]
                                    : null,
                                PassengerCount: counterCount.toInt(),
                              )));
                },
                child: Text('Search')),
          ],
        ),
      ),
    );
  }
}
