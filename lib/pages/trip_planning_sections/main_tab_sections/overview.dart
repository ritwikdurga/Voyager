// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/calender_picker.dart';
import 'package:voyager/components/search_section/date_section.dart';
import 'package:voyager/components/trip_planning_section/friends_icons.dart';
import 'package:voyager/components/trip_planning_section/profile_tile.dart';
import 'package:voyager/home_screen.dart';
import 'package:voyager/utils/constants.dart';

class OverviewTrips extends StatelessWidget {
  const OverviewTrips({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              children: [
                Text(
                  'Your Tripmates',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                  child: SizedBox(
                    height: 85,
                    width: screenWidth - 50,
                    child: FriendsIcons(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Row(
              children: [
                Text(
                  'Reservations and Attachments',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 80,
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  children: [
                    GestureDetector(
                      onTap: () {
                        AttachForFlights(context);
                      },
                      child: SizedBox(
                        width: screenWidth / 4 - 15,
                        height: 80,
                        child: Column(
                          children: [
                            Icon(
                              Icons.flight_takeoff,
                              size: 50,
                              color: Colors.white,
                            ),
                            Spacer(),
                            Text('Flights'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: VerticalDivider(
                        thickness: 0.25,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 4 - 15,
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.train,
                            size: 50,
                            color: Colors.white,
                          ),
                          Spacer(),
                          Text(
                            'Trains',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: VerticalDivider(
                        thickness: 0.25,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 4 - 15,
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Iconsax.bus5,
                            size: 50,
                            color: Colors.white,
                          ),
                          Spacer(),
                          Text(
                            'Buses',
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      child: VerticalDivider(
                        thickness: 0.25,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 4 - 15,
                      height: 80,
                      child: Column(
                        children: [
                          Icon(
                            Icons.attachment_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          Spacer(),
                          Text(
                            'Attachment',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: screenHeight / 2 - 10,
            child: ListView.builder(
              itemCount: 100,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (bc, index) {
                return ProfileTile();
              },
            ),
          ),
        ],
      );
    },
  );
}

void AttachForFlights(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: screenHeight / 2 - 10,
            width: screenWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Some Random Question?',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[600],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            ShowFormsForManualAttachment(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Add Manually',
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(initialIndex: 1)),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Search for Flights',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void ShowFormsForManualAttachment(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: screenHeight / 2 - 10,
            width: screenWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'Some Random Question?',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.grey[600],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.pop(context);
                            // ShowFormsForManualAttachment(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Round Trip',
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pop();
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           HomeScreen(initialIndex: 1)),
                          // );
                          showFormsForOneWay(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[600],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'One Way trip',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

DateTime? selectedDepartureDate = null;
DateTime? selectedArrivalDate = null;

void showFormsForOneWay(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              SizedBox(
                height: screenHeight / 2 - 10,
                width: screenWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Some Random Question?',
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Text('Departure Date'),
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
                                  //Navigator.pop(context);
                                  _showDatePickerDialog(context, false,
                                      (DateTime? date) {
                                    setState(() {
                                      selectedDepartureDate = date;
                                    });
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

void _showDatePickerDialog(
    BuildContext context, bool Arrival, Function(DateTime?) setDate) {
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
