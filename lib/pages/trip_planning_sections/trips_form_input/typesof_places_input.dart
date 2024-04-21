// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/trip_planning_sections/new_trip_page.dart';
import 'package:voyager/pages/trip_planning_sections/trips_form_input/tripmate_kind_input.dart';
import 'package:voyager/services/fetch_userdata.dart';
import 'package:voyager/utils/constants.dart';

class TypesOfPlaces extends StatefulWidget {
  String? locationSelected;
  DateTime? StartDate;
  DateTime? EndDate;
  String? tripmateKind;
  String? budget;
  TypesOfPlaces({
    super.key,
    required this.locationSelected,
    required this.StartDate,
    required this.EndDate,
    required this.tripmateKind,
    required this.budget,
  });

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
          padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              buildContainer(
                screenWidth,
                'Adventure and Outdoors',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Spiritual',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Relaxing',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'City Life',
                themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ),
              buildContainer(
                screenWidth,
                'Cultural',
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewTrip(
                              locationSelected: widget.locationSelected,
                              StartDate: widget.StartDate,
                              EndDate: widget.EndDate,
                              isManual: false,
                              tripmateKind: widget.tripmateKind,
                              tripPreferences: selectedTypes,
                              collaborators: [firebaseAuth.currentUser!.uid],
                              budget:widget.budget,
                            )));
              },
            ),
          ),
      ],
    );
  }

  Widget buildContainer(double screenWidth, String str, Color colour) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
            color: themeProvider.themeMode == ThemeMode.dark
            ? selectedTypes != null && selectedTypes!.contains(str)
                ? Colors.grey.shade400
                : Colors.grey.shade900
            : selectedTypes != null && selectedTypes!.contains(str)
                ? Colors.grey.shade900
                : Colors.grey.shade400,
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
