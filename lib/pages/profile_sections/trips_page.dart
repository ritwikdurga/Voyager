import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';

import '../../components/explore_section/trips_cards.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'profile_page.dart';

class ProfileTrips extends StatelessWidget {
  const ProfileTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final tripsProvider = Provider.of<TripsProvider>(context);
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
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                      ),
                      const SizedBox(height: 10),
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
