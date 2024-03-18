// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/trips_cards.dart';
import 'package:voyager/pages/trip_planning_sections/new_trip_page.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';

class AddTrips extends StatelessWidget {
  const AddTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: SizedBox(
              //     width:250,
              //     child: TextButton(
              //       style: ButtonStyle(
              //         foregroundColor: MaterialStateProperty.all<Color>(
              //           themeProvider.themeMode == ThemeMode.dark
              //               ? Colors.white
              //               : Colors.black,
              //         ),
              //         overlayColor: MaterialStateProperty.resolveWith<Color?>(
              //           (Set<MaterialState> states) {
              //             if (states.contains(MaterialState.focused) ||
              //                 states.contains(MaterialState.pressed))
              //               return Colors.blue;
              //             return null; // Defer to the widget's default.
              //           },
              //         ),
              //         backgroundColor:
              //             MaterialStateProperty.all<Color>(Colors.blueAccent),
              //         shape: MaterialStateProperty.all<OutlinedBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0),
              //           ),
              //         ),
              //       ),
              //       onPressed: () {},
              //       child: Text(
              //         'Continue Planning',
              //         style: TextStyle(
              //           fontSize: 24,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: SizedBox(
              //     width:250,
              //     child: TextButton(
              //       style: ButtonStyle(
              //         foregroundColor: MaterialStateProperty.all<Color>(
              //           themeProvider.themeMode == ThemeMode.dark
              //               ? Colors.white
              //               : Colors.black,
              //         ),
              //         overlayColor: MaterialStateProperty.resolveWith<Color?>(
              //           (Set<MaterialState> states) {
              //             if (states.contains(MaterialState.focused) ||
              //                 states.contains(MaterialState.pressed))
              //               return Colors.blue;
              //             return null; // Defer to the widget's default.
              //           },
              //         ),
              //         backgroundColor:
              //             MaterialStateProperty.all<Color>(Colors.blueAccent),
              //         shape: MaterialStateProperty.all<OutlinedBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(30.0),
              //           ),
              //         ),
              //       ),
              //       onPressed: () {},
              //       child: Text(
              //         'Plan A New Trip',
              //         style: TextStyle(
              //           fontSize: 24,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Text(
                'Welcome to the Trips Page!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'What would you like to do?',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                child: Text('Continue Planning Previous Trip'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // _showBottomSheet(context, 'Plan a New Trip');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewTrip()));
                },
                child: Text('Plan a New Trip'),
              ),
            ],
          ),
        ),
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
        //crossAxisAlignment:CrossAxisAlignment.end,
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
                itemCount: 10,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (bc, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 16, 16),
                    child: trips(screenWidth: screenWidth),
                  );
                }),
          ),
        ],
      );
    },
  );
}
