// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:voyager/pages/trip_planning_sections/trips_form_input/location_input.dart';
import 'package:voyager/pages/trip_planning_sections/trips_form_input/trip_length_input.dart';
import 'package:voyager/pages/trip_planning_sections/trips_form_input/tripmate_kind_input.dart';
import 'package:voyager/pages/trip_planning_sections/trips_form_input/typesof_places_input.dart';
import 'package:voyager/utils/constants.dart';

class PlanWithAI extends StatefulWidget {
  PlanWithAI({super.key});

  @override
  State<PlanWithAI> createState() => _PlanWithAIState();
}

class _PlanWithAIState extends State<PlanWithAI> {
  PageController _controller = PageController();
  TextEditingController _locationController = TextEditingController();
  bool locationSelected = false;
  String? selectedLocation;
  DateTime? departure;
  DateTime? arrival;
  String? tripMateKind;

  @override
  void dispose() {
    _controller.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _showErrorSnackbar(String Error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar
        content: Center(
          child: Text(
            Error,
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the text color
            ),
          ),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          Flexible(
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: SlideEffect(
                  spacing: 8,
                  radius: 4,
                  dotWidth: 40,
                  dotHeight: 8,
                  dotColor: Colors.grey.shade400,
                  activeDotColor: kGreenColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              if (index > 0 && !locationSelected) {
                _showErrorSnackbar('Please select your destination.');
                _controller.jumpToPage(0);
              }
              if (index > 1 && (departure == null || arrival == null)) {
                _showErrorSnackbar('Please select the Start or End date.');
                _controller.jumpToPage(1);
              }
              if (index > 2 && tripMateKind == null) {
                _showErrorSnackbar('Please select Yout tripmate kind.');
                _controller.jumpToPage(2);
              }
            },
            children: [
              LocationInput(
                initialLocation: selectedLocation,
                onLocationSelected: (location) {
                  setState(() {
                    _locationController.text = location;
                    locationSelected = true;
                    selectedLocation = location;
                  });
                },
              ),
              tripLength(onDatesSelected: (DepartureDate, ArrivalDate) {
                setState(() {
                  departure = DepartureDate;
                  arrival = ArrivalDate;
                });
              }),
              TripMateKind(onTripMateSelected: (tripMateKind) {
                setState(() {
                  this.tripMateKind = tripMateKind;
                });
              }),
              TypesOfPlaces(
                locationSelected: selectedLocation,
                StartDate: departure,
                EndDate: arrival,
                tripmateKind: tripMateKind,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
