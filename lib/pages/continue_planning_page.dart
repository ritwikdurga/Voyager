// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:voyager/components/trips_cards.dart";

class ContPlanning extends StatefulWidget {
  const ContPlanning({super.key});

  @override
  State<ContPlanning> createState() => _ContPlanningState();
}

class _ContPlanningState extends State<ContPlanning> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Continue Planning'),
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