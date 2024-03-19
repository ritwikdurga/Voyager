// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/trips_cards.dart';
import 'package:voyager/pages/trip_planning_sections/new_trip_page.dart';
import 'package:voyager/pages/trip_planning_sections/plan_with_ai.dart';
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
              Text(
                'No plans yet? No problem!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProductSans',
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Your journey starts here.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProductSans',
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        _showBottomSheetForContinuePlanning(context);
                      },
                      child: Text('Continue Planning'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => NewTrip()));
                        _showBottomSheetForNewTrip(context);
                      },
                      child: Text('Plan a New Trip'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showBottomSheetForContinuePlanning(BuildContext context) {
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

void _showBottomSheetForNewTrip(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No plans yet? No problem!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ProductSans',
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Your journey starts here.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'ProductSans',
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    //_showBottomSheetForContinuePlanning(context);
                  },
                  child: Text('Manual'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlanWithAI()));
                    //_showBottomSheetForNewTrip(context);
                  },
                  child: Text('Plan with AI'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
