// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_import, must_be_immutable, unnecessary_import, non_constant_identifier_names, prefer_final_fields, use_super_parameters, avoid_print

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/explore_sections/explore_page.dart';
import 'package:voyager/pages/trip_planning_sections/add_trips_page.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/expenses.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/explore.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/itinerary.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/overview.dart';
import 'package:voyager/pages/trip_planning_sections/trips_form_input/tripmate_kind_input.dart';
import 'package:voyager/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContinuePlanning extends StatefulWidget {
  String? locationSelected;
  DateTime? startDate;
  DateTime? endDate;
  String? tripmateKind;
  List<String>? tripPreferences;
  bool? isManual;
  late List<dynamic> collaborators;
  late String tripId;
  bool isNewTripPage = false;
  bool isBookmarked = false;
  ContinuePlanning({
    Key? key,
    required this.tripId,
    required this.isNewTripPage,
    required this.isBookmarked,
  }) : super(key: key);

  @override
  State<ContinuePlanning> createState() => _ContinuePlanningState();
}

class _ContinuePlanningState extends State<ContinuePlanning>
    with TickerProviderStateMixin {
  final db = FirebaseFirestore.instance;
  late DocumentReference tripRef;
  late TabController _tabController;
  double screenHeight = 0;
  TextEditingController _HeadingTextController = TextEditingController();
  bool _dataFetched = false;
  @override
  void initState() {
    super.initState();
    tripRef = db.collection("trips").doc(widget.tripId);
    fetchTripData();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  void updateTitle(String title) async {
    await tripRef.update({
      'title': title,
    });
  }

  void fetchTripData() async {
    try {
      final tripDoc = await tripRef.get();
      if (tripDoc.exists) {
        setState(() {
          print("object");
          _HeadingTextController.text = tripDoc['title'];
          Timestamp tempStartDate = tripDoc['startDate'];
          widget.startDate = tempStartDate.toDate();
          Timestamp tempEndDate = tripDoc['endDate'];
          widget.endDate = tempEndDate.toDate();
          widget.locationSelected = tripDoc['location'];
          widget.collaborators = tripDoc['collaborators'];
          print("hi");
          if (tripDoc['tripPreferences'] != null) {
            widget.tripPreferences =
                List<String>.from(tripDoc['tripPreferences']);
          }
          widget.tripmateKind = tripDoc['tripmateKind'];
          widget.isManual = tripDoc['isManual'];
          _dataFetched = true;
        });
      } else {
        print("Trip with ID ${widget.tripId} does not exist");
      }
    } catch (error) {
      print("Error fetching trip data: $error");
    }
  }

  void deleteTrip() async {
    try {
      for (int index = 0; index < widget.collaborators.length; index++) {
        final DocumentReference user =
            db.collection("users").doc(widget.collaborators[index]);
        await user.update({
          'trips': FieldValue.arrayRemove([
            {'tripId': widget.tripId, 'isBookmarked': widget.isBookmarked}
          ])
        });
      }
      await tripRef.delete();
    } catch (error) {
      print(error);
    }
  }

  late StreamSubscription<DocumentSnapshot> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_dataFetched) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      _subscription = tripRef.snapshots().listen((snapshot) {
        if (snapshot.exists) {
          String title = snapshot['title'];
          if (title != _HeadingTextController.text) {
            setState(() {
              _HeadingTextController.text = title;
            });
          }
        }
      }, onError: (error) {
        print("Stream Subscription Error: $error");
      });
      final themeProvider = Provider.of<ThemeProvider>(context);
      screenHeight = MediaQuery.of(context).size.height;
      return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (_tabController.index == 0)
              SizedBox(
                height: screenHeight / 3,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/a.png',
                  fit: BoxFit.cover,
                ),
              ),
            if (_tabController.index == 0)
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Spacer(),
                          GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onTap: () {
                                deleteTrip();
                                if (widget.isNewTripPage) {
                                  Navigator.popUntil(context, (route) {
                                    if (route.isFirst) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  });
                                } else {
                                  Navigator.pop(context);
                                }
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: TextField(
                        controller: _HeadingTextController,
                        style: TextStyle(
                          color: Colors.white,
                          // Changed color to black for better visibility
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ProductSans',
                          fontSize: 40,
                        ),
                        textAlign: TextAlign.center,
                        onEditingComplete: () {
                          updateTitle(_HeadingTextController.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        decoration: null,
                      ),
                    ),
                    Text(
                      '${DateFormat('dd MMM').format(widget.startDate ?? DateTime.now())}-${DateFormat('dd MMM').format(widget.endDate ?? DateTime.now())}',
                      style: TextStyle(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.only(
                  top: _tabController.index == 0 ? screenHeight / 3 - 20 : 30),
              child: AnimatedSize(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 600),
                child: Container(
                  height: _tabController.index == 0
                      ? 2 * screenHeight / 3 + 20
                      : screenHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.black
                              : Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TabBar(
                            controller: _tabController,
                            dividerColor:
                                themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.black
                                    : Colors.white,
                            tabs: [
                              buildTab(Iconsax.information),
                              buildTab(Iconsax.search_normal),
                              buildTab(Iconsax.map),
                              buildTab(Iconsax.dollar_circle),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: IndexedStack(
                          index: _tabController.index,
                          children: [
                            OverviewTrips(
                              tripRef: tripRef,
                            ),
                            ExploreTrips(),
                            ItineraryTrips(
                                startDate: widget.startDate,
                                endDate: widget.endDate),
                            ExpensesTrips(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildTab(IconData icon) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white30,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 30,
      ),
    );
  }
}
