// ignore_for_file: use_super_parameters, unused_local_variable, avoid_print, prefer_const_constructors, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

import '../explore_sections/continue_planning_page.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final tripsProvider = Provider.of<TripsProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      body: SafeArea(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       'No plans yet? No problem!',
        //       style: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'ProductSans',
        //       ),
        //     ),
        //     SizedBox(height: 2),
        //     Text(
        //       'Your journey starts here.',
        //       style: TextStyle(
        //         fontSize: 20,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'ProductSans',
        //       ),
        //     ),
        //     SizedBox(height: 40),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         SizedBox(
        //           width: 180,
        //           child: ElevatedButton(
        //             onPressed: () {
        //               _showBottomSheetForContinuePlanning(
        //                   context,
        //                   tripsProvider.tripList.length,
        //                   tripsProvider.tripList);
        //             },
        //             child: Text('Continue Planning'),
        //           ),
        //         ),
        //         SizedBox(height: 10),
        //         SizedBox(
        //           width: 180,
        //           child: ElevatedButton(
        //             onPressed: () {
        //               _showBottomSheetForNewTrip(context);
        //             },
        //             child: Text('Plan a New Trip'),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text(
                      'Your Trips',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContPlanning()));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 6.5,
              ),
              SizedBox(
                height: screenHeight / 1.55,
                child: tripsProvider.tripList.isEmpty
                    ? Center(
                  child: Text(
                    'No active trips.',
                    style: TextStyle(fontSize: 20,
                      fontFamily: 'ProductSans',
                      fontWeight: FontWeight.bold,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                )
                    : SizedBox(
                  height: screenWidth / 3 + 20,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tripsProvider.tripList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Trip trip = tripsProvider.tripList[index];
                      return trips(
                        screenWidth: screenWidth,
                        trip: trip,
                        isNewTripPage: false,
                        isBookmarked: tripsProvider.tripList[index].isBookmarked,
                        index: 0,
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlanWithAI()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_location_alt_sharp,
                            color: Colors.blueAccent,
                          ),
                          // Location icon here
                          SizedBox(width: 5),
                          // Add some spacing between icon and text
                          Text(
                            'Plan with AI',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProductSans',
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlanManual()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.blueAccent,
                          ),
                          // Add icon here
                          SizedBox(width: 5),
                          // Add some spacing between icon and text
                          Text(
                            'Create a Trip',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'ProductSans',
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
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
