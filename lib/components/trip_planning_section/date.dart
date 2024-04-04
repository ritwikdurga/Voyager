import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:voyager/utils/constants.dart';

class DatePage extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  DateTime? selectedDay;
  DateTime? focusedDay;
  DatePage(
      {required this.onDateSelected,
      required this.focusedDay,
      required this.selectedDay});

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime? _selectedDay;
  late DateTime? _focusedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay =
        widget.selectedDay != null ? widget.selectedDay : DateTime.now();
    _focusedDay =
        widget.focusedDay != null ? widget.focusedDay : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios, size: 20)),
                  SizedBox(width: screenWidth * 0.20),
                  Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ProductSans',
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay != null ? _focusedDay! : DateTime.now(),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            ElevatedButton(
              onPressed: () {
                widget.onDateSelected(_selectedDay);
                Navigator.pop(context);
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
