import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnDateSelected(date);

class HorizontalCalendarCustom extends StatefulWidget {
  HorizontalCalendarCustom({
    Key? key,
    required this.date,
    DateTime? initialDate,
    DateTime? lastDate,
    this.textColor,
    this.backgroundColor,
    this.selectedColor,
    this.showMonth = false,
    this.locale = const Locale('en', ''),
    required this.onDateSelected,
  })  : initialDate = DateUtils.dateOnly(initialDate ?? DateTime.now()),
        lastDate = DateUtils.dateOnly(
            lastDate ?? DateTime.now().add(Duration(days: 90))),
        super(key: key) {
    assert(
      !this.lastDate.isBefore(this.initialDate),
      'lastDate ${this.lastDate} must be on or after initialDate ${this.initialDate}.',
    );
    assert(
      !this.initialDate.isBefore(this.initialDate),
      'initialDate ${this.initialDate} must be on or after initialDate ${this.initialDate}.',
    );
    assert(
      !this.initialDate.isAfter(this.lastDate),
      'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.',
    );
  }

  final DateTime date;
  final DateTime initialDate;
  final DateTime lastDate;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? selectedColor;
  final bool showMonth;
  final Locale locale;
  final OnDateSelected onDateSelected;

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<HorizontalCalendarCustom> {
  late DateTime _startDate;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    _startDate = selectedDate.subtract(Duration(days: 3));

    return Container(
      height: height * (widget.showMonth ? 8 : 8),
      color: widget.backgroundColor ?? Colors.white,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0.0),
        title: Offstage(),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CalendarItems(
                    index: index,
                    startDate: _startDate,
                    initialDate: widget.initialDate,
                    selectedDate: selectedDate,
                    textColor: widget.textColor ?? Colors.black45,
                    selectedColor:
                        widget.selectedColor ?? Theme.of(context).primaryColor,
                    backgroundColor: widget.backgroundColor ?? Colors.white,
                    locale: widget.locale,
                    onDatePressed: () =>
                        onDatePressed(index, widget.initialDate),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDatePressed(int index, DateTime? initialDate) {
    DateTime date = _startDate.add(Duration(days: index));
    int checkDate = date.difference(widget.initialDate).inDays;
    if (checkDate >= 0) {
      widget.onDateSelected(date);
      setState(() {
        selectedDate = _startDate.add(Duration(days: index));
        _startDate = _startDate.add(Duration(days: index));
      });
    }
  }
}

class CalendarItems extends StatelessWidget {
  final int index;
  final DateTime startDate;
  final DateTime? initialDate;
  final DateTime selectedDate;
  final Color textColor;
  final Color selectedColor;
  final Color backgroundColor;
  final Locale locale;
  final VoidCallback onDatePressed;

  const CalendarItems({
    required this.index,
    required this.startDate,
    required this.initialDate,
    required this.selectedDate,
    required this.textColor,
    required this.selectedColor,
    required this.backgroundColor,
    required this.locale,
    required this.onDatePressed,
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = startDate.add(Duration(days: index));
    bool isSelected = currentDate == selectedDate;
    bool isDisabled = currentDate.isBefore(initialDate!);
    String day = DateFormat('EEE', locale.toString()).format(currentDate);

    return GestureDetector(
      onTap: isDisabled ? null : onDatePressed,
      child: Container(
        width: 70, // Increase the width of each date box
        // margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                color: isDisabled ? Colors.grey : textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${currentDate.day}',
              style: TextStyle(
                color: isDisabled
                    ? Colors.grey
                    : isSelected
                        ? Colors.white
                        : textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
