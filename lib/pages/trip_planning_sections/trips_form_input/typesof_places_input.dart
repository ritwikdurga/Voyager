// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/trip_planning_sections/new_trip_page.dart';
import 'package:voyager/utils/constants.dart';

class TypesOfPlaces extends StatefulWidget {
  String? locationSelected;
  DateTime? StartDate;
  DateTime? EndDate;
  TypesOfPlaces({super.key,required this.locationSelected,required this.StartDate,required this.EndDate,});

  @override
  State<TypesOfPlaces> createState() => _TypesOfPlacesState();
}

class _TypesOfPlacesState extends State<TypesOfPlaces> {
  List<String>? selectedTypes;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          'How do you want to spend your time?',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 24,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose as many as you\'d like',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(1,0,0,0),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              buildContainer(
                screenWidth,
                'History and Culture',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Museum',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Local Experiences',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Scenic',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Adventure',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Food and Drinks',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Religious',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Shows and concerts',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Shopping',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ],
          ),
        ),
        if (selectedTypes != null)
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GestureDetector(
              child: Container(
                height: 50,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade900
                      : Colors.grey.shade200,
                ),
                child: Center(
                  child: Text(
                    'Done',
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => NewTrip(
                      locationSelected: widget.locationSelected,
                      StartDate: widget.StartDate,
                      EndDate: widget.EndDate,
                    )));
              },
            ),
          ),
      ],
    );
  }

  Widget buildContainer(double screenWidth, String str, Color colour) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedTypes != null && selectedTypes!.contains(str)) {
            selectedTypes!.remove(str);
            if (selectedTypes!.isEmpty) {
              selectedTypes = null;
            }
          } else {
            if (selectedTypes == null) {
              selectedTypes = [str];
            } else {
              selectedTypes!.add(str);
            }
          }
        });
      },
      child: Container(
        // width: screenWidth / 2 - 15,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedTypes != null && selectedTypes!.contains(str)
                ? Colors.grey.shade600
                : Colors.grey.shade900,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                str,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                  color: colour,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
