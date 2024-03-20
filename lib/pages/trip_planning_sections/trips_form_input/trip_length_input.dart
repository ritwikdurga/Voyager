// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/utils/constants.dart';

class tripLength extends StatefulWidget {
  final Function(DateTime?,DateTime?) onDatesSelected;
  tripLength({super.key,required this.onDatesSelected});

  @override
  State<tripLength> createState() => _tripLengthState();
}

class _tripLengthState extends State<tripLength>
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
                      widget.onDatesSelected(selectedDepartureDate,selectedArrivalDate);
                    } else {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: kRedColor,
                          // Change the background color of the snackbar
                          content: Center(
                            child: Text(
                              'The End Date should be after the start date.',
                              style: TextStyle(
                                fontSize: 16, // Change the font size as needed
                                fontFamily:
                                    'ProductSans', // Change the font family as needed
                                color: Colors.white, // Change the text color
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
      ],
    );
  }
}
