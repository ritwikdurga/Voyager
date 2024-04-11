// ignore_for_file: use_super_parameters, unused_local_variable, avoid_print, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyager/components/explore_section/trips_cards.dart';
import 'package:voyager/pages/trip_planning_sections/new_trip_page.dart';
import 'package:voyager/pages/trip_planning_sections/plan_manual.dart';
import 'package:voyager/pages/trip_planning_sections/plan_with_ai.dart';
import 'package:voyager/models/trip_model.dart';
import 'package:voyager/services/fetch_userdata.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';

class AddTrips extends StatefulWidget {
  const AddTrips({Key? key}) : super(key: key);

  @override
  State<AddTrips> createState() => _AddTripsState();
}

class _AddTripsState extends State<AddTrips> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final tripsProvider = Provider.of<TripsProvider>(context);

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
                        _showBottomSheetForContinuePlanning(
                            context,
                            tripsProvider.tripList.length,
                            tripsProvider.tripList);
                      },
                      child: Text('Continue Planning'),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
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

void _showBottomSheetForContinuePlanning(
    BuildContext context, int length, List<Trip> tripList) {
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
                itemCount: length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (bc, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 16, 16),
                    child: trips(
                      screenWidth: screenWidth,
                      trip: tripList[index],
                    ),
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
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlanManual()));
                  },
                  child: Text('Manual'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlanWithAI()));
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
