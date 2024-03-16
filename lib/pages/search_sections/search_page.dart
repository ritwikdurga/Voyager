// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/search_section/circle_tab_indicator.dart';
import 'package:voyager/components/search_section/flight_search.dart';
import 'package:voyager/components/search_section/tab_view_icons.dart';
import 'package:voyager/components/search_section/train_search.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';

class Booking extends StatefulWidget {
  Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: double.maxFinite,
              child: TabBar(
                controller: _tabController,
                indicator: CircleTabIndicator(
                  color: kGreenColor,
                  radius: 4,
                ),
                dividerColor: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.black
                    : Colors.white,
                tabs: [
                  TabViewIcon(
                      icon: Icons.train_outlined,
                      text: 'Trains',
                      rightDivider: true),
                  TabViewIcon(
                      icon: Icons.flight_takeoff_sharp,
                      text: 'Flights',
                      rightDivider: false),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [TrainSearch(), FlightSearch()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
