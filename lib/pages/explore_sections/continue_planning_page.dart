// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/trips_cards.dart";
import "package:voyager/utils/colors.dart";
import "package:voyager/utils/constants.dart";

class ContPlanning extends StatefulWidget {
  const ContPlanning({super.key});

  @override
  State<ContPlanning> createState() => _ContPlanningState();
}

class _ContPlanningState extends State<ContPlanning> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              // display the trips
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}
