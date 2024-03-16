import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/trips_cards.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'profile_page.dart';

class ProfileTrips extends StatelessWidget {
  const ProfileTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // take the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      appBar: AppBar(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        title: Text(' My Trips',
            style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProductSans')),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Add functionality here to navigate back
            // For example: Navigator.pop(context);
          },
        ),
      ),
      // display the trips
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
