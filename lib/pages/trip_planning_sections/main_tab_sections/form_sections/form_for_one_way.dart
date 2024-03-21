// ignore_for_file: prefer_const_constructors, avoid_init_to_null, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'package:customizable_counter/customizable_counter.dart';
import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/components/search_section/date_section.dart';
import 'package:voyager/utils/constants.dart';

class FormForOneWay extends StatefulWidget {
  const FormForOneWay({super.key});

  @override
  State<FormForOneWay> createState() => _FormForOneWayState();
}

class _FormForOneWayState extends State<FormForOneWay> {
  void _showDatePickerDialog(
      BuildContext context, bool Arrival, Function(DateTime?) setDate) {
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
                  if (Arrival) {
                    setDate(null);
                  }
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
                setDate(date);
              },
            ),
          ),
        );
      },
    );
  }

  int stopCount = 0;
  List<TicketData> ticketsData = [
    TicketData(
      fromAirport: '',
      toAirport: '',
      topText: '',
      bottomText: '',
      price: 0,
      isLastItem: false,
      passengers: 0,
      duration: '',
      flightNumber: '',
      flightOperator: '',
      fromDate: '',
      toDate: '',
      fromTime: '',
      toTime: '',
    ),
  ];
  List<DateTime?> selectedDepartureDates = [null];
  List<DateTime?> selectedArrivalDates = [null];
  List<String?> selectedDepartureTimes=[null];
  List<String?> selectedArrivalTimes=[null];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Form for One Way Flights'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Some Random Question?',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text('Number of Stops'),
                      Spacer(),
                      CustomizableCounter(
                        borderWidth: 1,
                        showButtonText: false,
                        count: 0,
                        step: 1,
                        minCount: 0,
                        incrementIcon: Icon(
                          Icons.add,
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        decrementIcon: Icon(
                          Icons.remove,
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ),
                        onCountChange: (count) {
                          for (int i = stopCount; i < count.toInt(); i++) {
                            ticketsData.add(TicketData(
                              fromAirport: '',
                              toAirport: '',
                              topText: '',
                              bottomText: '',
                              price: 0,
                              isLastItem: false,
                              passengers: 0,
                              duration: '',
                              flightNumber: '',
                              flightOperator: '',
                              fromDate: '',
                              toDate: '',
                              fromTime: '',
                              toTime: '',
                            ));
                            selectedDepartureDates.add(null);
                            selectedArrivalDates.add(null);
                            selectedDepartureTimes.add(null);
                            selectedArrivalTimes.add(null);
                          }
                          for (int i = stopCount; i > count.toInt(); i--) {
                            //debugPrint('j: $i');
                            ticketsData.removeLast();
                            selectedDepartureDates.removeLast();
                            selectedArrivalDates.removeLast();
                            selectedDepartureTimes.removeLast();
                            selectedArrivalTimes.removeLast();
                          }
                          //debugPrint(ticketsData.length.toString());
                          setState(() {
                            stopCount = count.toInt();
                          });
                          //counterCount=count;
                        },
                        onIncrement: (count) {},
                        onDecrement: (count) {},
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: stopCount + 1,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (stopCount == 0)
                                Text('Departure Date')
                              else
                                Text('Departure Date for flight ${index + 1}'),
                              Spacer(),
                              if (selectedDepartureDates[index] != null)
                                DateDisplayer(
                                  Date: selectedDepartureDates[index]!
                                      .day
                                      .toString(),
                                  Day: selectedDepartureDates[index]!.weekday,
                                  month: selectedDepartureDates[index]!.month,
                                  Year: selectedDepartureDates[index]!
                                      .year
                                      .toString(),
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
                                  _showDatePickerDialog(context, false,
                                      (DateTime? date) {
                                    setState(() {
                                      selectedDepartureDates[index] = date;
                                      debugPrint(selectedDepartureDates[index]
                                          .toString());
                                      debugPrint(date.toString());
                                    });
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              if (stopCount == 0)
                                Text('Arrival Date')
                              else
                                Text('Arrival Date for flight ${index + 1}'),
                              Spacer(),
                              if (selectedArrivalDates[index] != null)
                                DateDisplayer(
                                  Date: selectedArrivalDates[index]!
                                      .day
                                      .toString(),
                                  Day: selectedArrivalDates[index]!.weekday,
                                  month: selectedArrivalDates[index]!.month,
                                  Year: selectedArrivalDates[index]!
                                      .year
                                      .toString(),
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
                                  _showDatePickerDialog(context, true,
                                      (DateTime? date) {
                                    setState(() {
                                      selectedArrivalDates[index] = date;
                                      debugPrint(selectedArrivalDates[index]
                                          .toString());
                                      debugPrint(date.toString());
                                    });
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              if(stopCount==0)
                                Text('Departure Time')
                              else 
                                Text('Departure Time for flight ${index+1}'),
                              Spacer(),
                              SizedBox(
                                width:80,
                                child: DateTimePicker(
                                  type: DateTimePickerType.time,
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val){
                                    setState(() {
                                      selectedDepartureTimes[index]=val;
                                      debugPrint(selectedDepartureTimes[index]!);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if(stopCount==0)
                                Text('Arrival Time')
                              else 
                                Text('Arrival Time for flight ${index+1}'),
                              Spacer(),
                              SizedBox(
                                width:80,
                                child: DateTimePicker(
                                  type: DateTimePickerType.time,
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val){
                                    setState(() {
                                      selectedArrivalTimes[index]=val;
                                      debugPrint(selectedArrivalTimes[index]!);
                                    });
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TicketData {
  final String fromAirport;
  final String toAirport;
  final String topText;
  final String bottomText;
  final int price;
  final bool isLastItem;
  final int passengers;
  final String duration;
  final String flightNumber;
  final String flightOperator;
  final String fromDate;
  final String toDate;
  final String fromTime;
  final String toTime;

  TicketData({
    required this.fromAirport,
    required this.toAirport,
    required this.topText,
    required this.bottomText,
    required this.price,
    required this.isLastItem,
    required this.passengers,
    required this.duration,
    required this.flightNumber,
    required this.flightOperator,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'fromAirport': fromAirport,
      'toAirport': toAirport,
      'topText': topText,
      'bottomText': bottomText,
      'price': price,
      'isLastItem': isLastItem,
      'passengers': passengers,
      'duration': duration,
      'flightNumber': flightNumber,
      'flightOperator': flightOperator,
      'fromDate': fromDate,
      'toDate': toDate,
      'fromTime': fromTime,
      'toTime': toTime,
    };
  }
}
