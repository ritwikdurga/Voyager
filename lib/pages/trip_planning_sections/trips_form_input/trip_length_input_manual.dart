// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/pages/trip_planning_sections/new_trip_page.dart';
import 'package:voyager/utils/constants.dart';

class tripLengthManual extends StatefulWidget {
  final Function(DateTime?, DateTime?) onDatesSelected;
  String locationSelected;
  tripLengthManual(
      {super.key,
      required this.onDatesSelected,
      required this.locationSelected});

  @override
  State<tripLengthManual> createState() => _tripLengthManualState();
}

class _tripLengthManualState extends State<tripLengthManual>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  List<String> months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC'
  ];

  DateTime? selectedDepartureDate = null;
  DateTime? selectedArrivalDate = null;
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
                    if (selectedDepartureDate != null &&
                        date.isAfter(selectedDepartureDate!)) {
                      selectedArrivalDate = date;
                      widget.onDatesSelected(
                          selectedDepartureDate, selectedArrivalDate);
                    } else {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kRedColor,
                          content: Center(
                            child: Text(
                              'The End Date should be after the start date.',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'ProductSans',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          'Preferred dates of travel?',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 24,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 80,
            width: screenWidth - 20,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 24,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _showDatePickerDialog(context, false);
                    },
                    icon: Icon(
                      Iconsax.calendar5,
                      size: 27,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedDepartureDate != null
                            ? days[selectedDepartureDate!.weekday - 1]
                            : 'DAY',
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        selectedDepartureDate != null
                            ? '${selectedDepartureDate!.day.toString()} ${months[selectedDepartureDate!.month - 1]}'
                            : 'DD MMM',
                        style: TextStyle(
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      _showDatePickerDialog(context, true);
                    },
                    icon: Icon(
                      Iconsax.calendar5,
                      size: 27,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedArrivalDate != null
                              ? days[selectedArrivalDate!.weekday - 1]
                              : 'DAY',
                          style: TextStyle(
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          selectedArrivalDate != null
                              ? '${selectedArrivalDate!.day.toString()} ${months[selectedArrivalDate!.month - 1]}'
                              : 'DD MMM',
                          style: TextStyle(
                            fontFamily: 'ProductSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (selectedDepartureDate != null && selectedArrivalDate != null)
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Your Trip is for ${selectedArrivalDate!.difference(selectedDepartureDate!).inDays + 1} days',
              style: TextStyle(
                fontFamily: 'ProductSans',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        if (selectedDepartureDate != null && selectedArrivalDate != null)
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              child: Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade900
                      : Colors.grey.shade200,
                ),
                child: Center(
                  child: Text(
                    'Done',
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTrip(
                              locationSelected: widget.locationSelected,
                              StartDate: selectedDepartureDate,
                              EndDate: selectedArrivalDate,
                              isManual: true,
                            )));
              },
            ),
          ),
      ],
    );
  }
}