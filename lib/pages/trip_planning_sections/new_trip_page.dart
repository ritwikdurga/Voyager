// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/explore_sections/explore_page.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/expenses.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/explore.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/itinerary.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/overview.dart';
import 'package:voyager/utils/constants.dart';

class NewTrip extends StatefulWidget {
  String? locationSelected;
  DateTime? StartDate;
  DateTime? EndDate;

  NewTrip(
      {Key? key,
      required this.locationSelected,
      required this.StartDate,
      required this.EndDate})
      : super(key: key);

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> with TickerProviderStateMixin {
  late TabController _tabController;
  double screenHeight = 0;
  TextEditingController _HeadingTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    _HeadingTextController.text = widget.locationSelected!;
  }

  @override
  Widget build(BuildContext context) {
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
                      onChanged: (newValue) {
                        // Update the value in yourTextEditingController or handle the change as needed
                      },
                      decoration: null,
                    ),
                  ),
                  Text(
                    '${DateFormat('dd MMM').format(widget.StartDate!)}-${DateFormat('dd MMM').format(widget.EndDate!)}',
                    style: TextStyle(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(
                top: _tabController.index == 0 ? screenHeight / 3 - 20 : 30),
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration: Duration(milliseconds: 300),
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
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          OverviewTrips(),
                          ExploreTrips(),
                          ItineraryTrips(
                              startDate: widget.StartDate,
                              endDate: widget.EndDate),
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
