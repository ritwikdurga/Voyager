import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'date_picker.dart';

class CustomStartEndCal extends StatefulWidget {
  CustomStartEndCal({
    Key? key,
    required this.onDateRangeSelected,
    required this.selectedStartDate,
    required this.selectedEndDate,
    this.textColor,
    this.selectedColor,
  }) : super(key: key);

  final Function(DateTime?, DateTime?) onDateRangeSelected;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final Color? textColor;
  final Color? selectedColor;

  @override
  _CustomStartEndCalState createState() => _CustomStartEndCalState();
}

class _CustomStartEndCalState extends State<CustomStartEndCal> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _selectedStartDate = widget.selectedStartDate ??
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _selectedEndDate = widget.selectedEndDate ??
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .add(Duration(days: 7));
    print('Start Date: $_selectedStartDate');
    print('End Date: $_selectedEndDate');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                _selectDate(context, isStartDate: true);
              },
              child: Icon(Icons.calendar_today),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    _selectedEndDate.difference(_selectedStartDate).inDays +
                        1, // Include the end date
                itemBuilder: (context, index) {
                  final currentDate =
                      _selectedStartDate.add(Duration(days: index));
                  final isSelected =
                      currentDate.isAtSameMomentAs(_selectedStartDate) ||
                          currentDate.isAtSameMomentAs(_selectedEndDate) ||
                          (currentDate.isAfter(_selectedStartDate) &&
                              currentDate.isBefore(_selectedEndDate));

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? widget.selectedColor ??
                              Theme.of(context).primaryColor
                          : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_getWeekdayAbbreviation(currentDate)}',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : widget.textColor ?? Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${_getMonthAbbreviation(currentDate.month)} ${currentDate.day}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : widget.textColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime? oldStartDate = _selectedStartDate;
    final DateTime? oldEndDate = _selectedEndDate;

    final List<DateTime?>? picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime? startDate = _selectedStartDate;
        DateTime? endDate = _selectedEndDate;
        return AlertDialog(
          title: Text('Select Date Range'),
          content: DateRangePicker(
            startSelectedDate: startDate,
            endSelectedDate: endDate,
            onDateSelected: (List<DateTime?>? selectedDates) {
              if (selectedDates != null && selectedDates.length == 2) {
                startDate = DateTime(selectedDates[0]!.year,
                    selectedDates[0]!.month, selectedDates[0]!.day);
                endDate = DateTime(selectedDates[1]!.year,
                    selectedDates[1]!.month, selectedDates[1]!.day);
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, [startDate, endDate]);
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );

    if (picked != null && picked.length == 2) {
      setState(() {
        _selectedStartDate = picked[0]!;
        _selectedEndDate = picked[1]!;
      });
      widget.onDateRangeSelected(_selectedStartDate, _selectedEndDate);
    } else {
      // User canceled date selection, revert to old values
      setState(() {
        _selectedStartDate = oldStartDate!;
        _selectedEndDate = oldEndDate!;
      });
    }
  }

  String _getWeekdayAbbreviation(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  String _getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
