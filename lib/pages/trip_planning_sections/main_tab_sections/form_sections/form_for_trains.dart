// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/components/search_section/date_section.dart';
import 'package:voyager/utils/constants.dart';

class FormForTrain extends StatefulWidget {
  final Function(TrainData) onTrainTicketAdded;
  const FormForTrain({super.key, required this.onTrainTicketAdded});

  @override
  State<FormForTrain> createState() => _FormForTrainState();
}

class _FormForTrainState extends State<FormForTrain> {
  TextEditingController fromStationcontroller = TextEditingController();
  TextEditingController toStationcontroller = TextEditingController();
  TextEditingController TrainOperater = TextEditingController();
  TextEditingController TrainNumberOperater = TextEditingController();
  TextEditingController priceController = TextEditingController();
  DateTime? selectedDepartureDate = null;
  DateTime? selectedArrivalDate = null;
  bool isListViewVisibleForDeparture = false;
  bool isListViewVisibleForArrival = false;
  String? selectedFromStation = null;
  String? selectedToStation = null;
  String? selectedDepartureTime = null;
  String? selectedArrivalTime = null;
  String? TrainName = null;
  String? TrainNumber = null;
  String? Price = null;

  bool areTextFieldsFilled() {
    bool allFilled = true;
    allFilled &= fromStationcontroller.text.isNotEmpty;
    allFilled &= toStationcontroller.text.isNotEmpty;
    allFilled &= (selectedDepartureDate != null);
    allFilled &= (selectedArrivalDate != null);
    allFilled &= (selectedArrivalTime != null);
    allFilled &= (selectedDepartureTime != null);
    allFilled &= (TrainName != null);
    allFilled &= (TrainNumber != null);
    allFilled &= (Price != null);
    return allFilled;
  }

  List<Map<String, String>> getFilteredStations(String searchText) {
    return Stations.where((station) {
      final String code = station['code'] ?? '';
      final String name = station['name'] ?? '';
      return code.toLowerCase().contains(searchText.toLowerCase()) ||
          name.toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  void _showDatePickerDialog(BuildContext context, bool Arrival) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return SizedBox(
          height: 300,
          child: AlertDialog(
            backgroundColor: themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
            surfaceTintColor: themeProvider.themeMode == ThemeMode.dark
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: Text(
          'Add Your Train Journey',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Departure Date',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      if (selectedDepartureDate != null)
                        DateDisplayer(
                          Date: selectedDepartureDate!.day.toString(),
                          Day: selectedDepartureDate!.weekday,
                          month: selectedDepartureDate!.month,
                          Year: selectedDepartureDate!.year.toString(),
                          valid: true,
                        )
                      else
                        DateDisplayer(
                          Date: 'Month',
                          Day: 0,
                          month: 0,
                          Year: '',
                          valid: false,
                        ),
                      IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: () {
                          _showDatePickerDialog(context, false);
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Arrival Date',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      if (selectedArrivalDate != null)
                        DateDisplayer(
                          Date: selectedArrivalDate!.day.toString(),
                          Day: selectedArrivalDate!.weekday,
                          month: selectedArrivalDate!.month,
                          Year: selectedArrivalDate!.year.toString(),
                          valid: true,
                        )
                      else
                        DateDisplayer(
                          Date: 'Month',
                          Day: 0,
                          month: 0,
                          Year: '',
                          valid: false,
                        ),
                      IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: () {
                          _showDatePickerDialog(context, true);
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Departure Time',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: SizedBox(
                          width: 80,
                          child: DateTimePicker(
                            type: DateTimePickerType.time,
                            onChanged: (val) {
                              setState(() {
                                selectedDepartureTime = val;
                              });
                            },
                            validator: (val) {
                              return null;
                            },
                            onSaved: (val) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Arrival Time',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: SizedBox(
                          width: 80,
                          child: DateTimePicker(
                            type: DateTimePickerType.time,
                            onChanged: (val) {
                              setState(() {
                                selectedArrivalTime = val;
                              });
                            },
                            validator: (val) {
                              print(val);
                              return null;
                            },
                            onSaved: (val) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.95 * screenWidth,
                    child: TextField(
                      controller: TrainOperater,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.train,
                        ),
                        hintText: 'Train Name',
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
                          TrainName = TrainOperater.text;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          TrainName = TrainOperater.text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.95 * screenWidth,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      controller: TrainNumberOperater,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.numbers,
                        ),
                        hintText: 'Train Number',
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
                          TrainNumber = TrainNumberOperater.text;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          TrainNumber = TrainNumberOperater.text;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.95 * screenWidth,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      controller: priceController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.dollar_circle,
                        ),
                        hintText: 'Price',
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
                          Price = priceController.text;
                        });
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (areTextFieldsFilled())
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey[800],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text('Add To Trip',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    TrainData traindata = TrainData(
                      fromStation: fromStationcontroller.text,
                      toStation: toStationcontroller.text,
                      topText: selectedFromStation!,
                      bottomText: selectedToStation!,
                      price: priceController.text,
                      trainNumber: TrainNumber!,
                      trainOperater: TrainName!,
                      fromDate:
                          DateFormat('dd MMM').format(selectedDepartureDate!),
                      toDate: DateFormat('dd MMM').format(selectedArrivalDate!),
                      fromTime: selectedDepartureTime!,
                      toTime: selectedArrivalTime!,
                    );
                    widget.onTrainTicketAdded(traindata);
                  }),
          ],
        ),
      ),
    );
  }
}

class TrainData {
  late final String fromStation;
  late final String toStation;
  late final String topText;
  late final String bottomText;
  late final String price;
  late final String trainNumber;
  late final String trainOperater;
  late final String fromDate;
  late final String toDate;
  late final String fromTime;
  late final String toTime;
  String? note;

  TrainData({
    required this.fromStation,
    required this.toStation,
    required this.topText,
    required this.bottomText,
    required this.price,
    required this.trainNumber,
    required this.trainOperater,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'fromStation': fromStation,
      'toStation': toStation,
      'topText': topText,
      'bottomText': bottomText,
      'price': price,
      'trainNumber': trainNumber,
      'trainOperater': trainOperater,
      'fromDate': fromDate,
      'toDate': toDate,
      'fromTime': fromTime,
      'toTime': toTime,
      'note': note,
    };
  }
}
