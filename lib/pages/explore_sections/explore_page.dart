// ignore_for_file:  prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/destinations.dart';
import 'package:voyager/components/explore_section/past_searches.dart';
import 'package:voyager/components/explore_section/search_bar.dart';
import 'package:voyager/components/explore_section/trips_cards.dart';
import 'package:voyager/models/trip_model.dart';
import 'package:voyager/pages/explore_sections/continue_planning_page.dart';
import 'package:voyager/pages/explore_sections/for_you_expanded.dart';
import 'package:voyager/pages/explore_sections/popular_destinations_expanded.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';
import 'package:voyager/utils/constants.dart';
import 'package:voyager/services/fetch_userdata.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Search(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'Continue Planning',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 12,
                            ),
                          ],
                        ),
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
                  height: screenWidth / 3 + 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tripsProvider.tripList.length > 5
                        ? 5
                        : tripsProvider.tripList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Trip trip = tripsProvider.tripList[index];
                      return trips(
                        screenWidth: screenWidth,
                        trip: trip,
                        isNewTripPage: false,
                        isBookmarked:
                            tripsProvider.tripList[index].isBookmarked,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'For You',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForYouExp(
                                      heading: 'For You',
                                    )));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                      ],
                    )),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'Your Searches',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                  height: 45,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    PastSearches(
                      textData: 'Paris',
                    ),
                    PastSearches(
                      textData: 'Paris',
                    ),
                    PastSearches(
                      textData: 'Paris',
                    ),
                  ]),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'Popular Destinations',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'View All',
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PopDestExp()));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
