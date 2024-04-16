// ignore_for_file: prefer_const_constructors, avoid_print

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/trips_cards.dart";
import "package:voyager/pages/trip_planning_sections/trip_provider.dart";
import "package:voyager/services/fetch_userdata.dart";
import "package:voyager/utils/colors.dart";
import "package:voyager/utils/constants.dart";

class ContPlanning extends StatefulWidget {
  const ContPlanning({super.key});

  @override
  State<ContPlanning> createState() => _ContPlanningState();
}

class _ContPlanningState extends State<ContPlanning> {
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Continue Planning',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: tripsProvider.tripList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      trips(
                        screenWidth: screenWidth,
                        trip: tripsProvider.tripList[index],
                        isNewTripPage: false,
                        isBookmarked:
                            tripsProvider.tripList[index].isBookmarked,
                        index: 0,
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
