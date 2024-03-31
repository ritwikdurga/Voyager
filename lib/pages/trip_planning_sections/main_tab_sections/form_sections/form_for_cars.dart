// ignore_for_file: prefer_const_constructors

import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/components/search_section/date_section.dart';
import 'package:voyager/utils/constants.dart';

class FormForCars extends StatefulWidget {
  final Function(CarData) onCarAdded;
  const FormForCars({super.key, required this.onCarAdded});

  @override
  State<FormForCars> createState() => _FormForCarsState();
}

class _FormForCarsState extends State<FormForCars> {
  TextEditingController fromPlacecontroller = TextEditingController();
  TextEditingController toPlacecontroller = TextEditingController();
  TextEditingController carOperator = TextEditingController();
  TextEditingController priceController = TextEditingController();
  DateTime? selectedDepartureDate = null;
  DateTime? selectedArrivalDate = null;
  String? selectedFromPlace = null;
  String? selectedToPlace = null;
  String? selectedDepartureTime = null;
  String? selectedArrivalTime = null;
  String? CarName = null;
  String? Price = null;

  bool areTextFieldsFilled() {
    bool allFilled = true;
    allFilled &= fromPlacecontroller.text.isNotEmpty;
    allFilled &= toPlacecontroller.text.isNotEmpty;
    allFilled &= (selectedDepartureDate != null);
    allFilled &= (selectedArrivalDate != null);
    allFilled &= (selectedArrivalTime != null);
    allFilled &= (selectedDepartureTime != null);
    allFilled &= (CarName != null);
    allFilled &= (priceController.text.isNotEmpty);
    return allFilled;
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
          'Add Your Car Journey',
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
                          controller: fromPlacecontroller,
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
                          onTap: () {},
                          onChanged: (value) {
                            setState(() {
                              selectedFromPlace = fromPlacecontroller.text;
                            });
                          },
                        ),
                      ),
                    ],
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
                          controller: toPlacecontroller,
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
                          onTap: () {},
                          onChanged: (value) {
                            setState(() {
                              selectedToPlace = toPlacecontroller.text;
                            });
                          },
                        ),
                      ),
                    ],
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
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
                        padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
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
                      controller: carOperator,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Iconsax.car5,
                        ),
                        hintText: 'Car Name',
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
                        setState(() {});
                      },
                      onChanged: (value) {
                        setState(() {
                          CarName = carOperator.text;
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
                        setState(() {
                          Price = priceController.text;
                        });
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
                    CarData carData = CarData(
                        fromPlace: selectedFromPlace!,
                        toPlace: selectedToPlace!,
                        price: Price!,
                        carOperator: CarName!,
                        fromDate:
                            DateFormat('dd MMM').format(selectedDepartureDate!),
                        toDate:
                            DateFormat('dd MMM').format(selectedArrivalDate!),
                        fromTime: selectedDepartureTime!,
                        toTime: selectedArrivalTime!);
                    widget.onCarAdded(carData);
                  }),
          ],
        ),
      ),
    );
  }
}

class CarData {
  late final String fromPlace;
  late final String toPlace;
  late final String price;
  late final String carOperator;
  late final String fromDate;
  late final String toDate;
  late final String fromTime;
  late final String toTime;
  String? note;

  CarData({
    required this.fromPlace,
    required this.toPlace,
    required this.price,
    required this.carOperator,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    this.note,
  });
  Map<String, dynamic> toMap() {
    return {
      'fromPlace': fromPlace,
      'toPlace': toPlace,
      'price': price,
      'carOperator': carOperator,
      'fromDate': fromDate,
      'toDate': toDate,
      'fromTime': fromTime,
      'toTime': toTime,
      'note': note,
    };
  }

  factory CarData.fromMap(Map<String, dynamic> map) {
    return CarData(
      fromPlace: map['fromPlace'],
      toPlace: map['toPlace'],
      price: map['price'],
      carOperator: map['carOperator'],
      fromDate: map['fromDate'],
      toDate: map['toDate'],
      fromTime: map['fromTime'],
      toTime: map['toTime'],
      note: map['note'],
    );
  }
}
