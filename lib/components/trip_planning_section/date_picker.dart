import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  final void Function(DateTime?, DateTime?)?
      onDateRangeSelected; // Define the named parameter here

  DateRangePickerWidget({Key? key, this.onDateRangeSelected}) : super(key: key);

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectDateRange(BuildContext context) async {
    final List<DateTime?>? picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime? startDate = _startDate;
        DateTime? endDate = _endDate;
        return AlertDialog(
          title: Text('Select Date Range'),
          content: DateRangePicker(
            startSelectedDate: startDate,
            endSelectedDate: endDate,
            onDateSelected: (List<DateTime?>? selectedDates) {
              startDate = selectedDates![0];
              endDate = selectedDates[1];
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, [startDate, endDate]);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });

      // Call the callback function with the selected dates
      if (widget.onDateRangeSelected != null) {
        widget.onDateRangeSelected!(_startDate, _endDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Selected Date Range:',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        _startDate != null && _endDate != null
            ? Text(
                '${_startDate!.toString().split(' ')[0]} - ${_endDate!.toString().split(' ')[0]}')
            : Text('No date range selected'),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _selectDateRange(context),
          child: Text('Select Date Range'),
        ),
      ],
    );
  }
}

class DateRangePicker extends StatefulWidget {
  final DateTime? startSelectedDate;
  final DateTime? endSelectedDate;
  final ValueChanged<List<DateTime?>>? onDateSelected;

  DateRangePicker(
      {this.startSelectedDate, this.endSelectedDate, this.onDateSelected});

  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.startSelectedDate ?? DateTime.now();
    _endDate = widget.endSelectedDate ?? DateTime.now().add(Duration(days: 7));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text('Start Date'),
          subtitle: Text(_startDate.toString().split(' ')[0]),
          onTap: () => _selectDate(context, isStartDate: true),
          trailing: Icon(Icons.calendar_today),
        ),
        ListTile(
          title: Text('End Date'),
          subtitle: Text(_endDate.toString().split(' ')[0]),
          onTap: () => _selectDate(context, isStartDate: false),
          trailing: Icon(Icons.calendar_today),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!([_startDate, _endDate]);
      }
    }
  }
}
