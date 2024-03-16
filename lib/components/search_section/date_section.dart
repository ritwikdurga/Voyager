// ignore_for_file: non_constant_identifier_names, must_be_immutable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class DateDisplayer extends StatelessWidget {
  late String Date;
  late int Day;
  late String Year;
  late int month;
  late bool valid;
  DateDisplayer(
      {super.key,
      required this.Date,
      required this.Day,
      required this.month,
      required this.Year,
      required this.valid});
  // List of days
  List<String> days = [
    'day',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

// List of months with short form
  List<String> months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Text(
          '$Date ${months[month]}',
          style: TextStyle(
            color: valid
                ? themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black
                : Colors.grey[800],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${days[Day]} $Year',
          style: TextStyle(
            color: valid
                ? themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black
                : Colors.grey[800],
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
