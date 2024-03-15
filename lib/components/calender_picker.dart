import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

List<DateTime?> _singleDatePickerValueWithDefaultValue = [
  DateTime.now(),
];

class DatePicker extends StatefulWidget {
  DatePicker({Key? key, this.onDateSelected}) : super(key: key);
  final Function(DateTime)? onDateSelected;
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Colors.amber[900],
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: TextStyle(
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.white
            : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 90,
      controlsTextStyle: TextStyle(
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.white
            : Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      calendarType: CalendarDatePicker2Type.single,
    );
    return Container(
      color: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      height: 350,
      width: 400,
      child: CalendarDatePicker2(
        config: config,
        value: _singleDatePickerValueWithDefaultValue,
        onValueChanged: (dates) {
          setState(() {
            _singleDatePickerValueWithDefaultValue = dates;
          });
          if (widget.onDateSelected != null && dates.isNotEmpty) {
            widget.onDateSelected!(dates[0]!);
          }
        },
      ),
    );
  }
}
