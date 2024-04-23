import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';
import 'package:voyager/utils/colors.dart';

import '../../components/explore_section/trips_cards.dart';
import '../../utils/constants.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tripsProvider = Provider.of<TripsProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      appBar: AppBar(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        title: Text('Wishlist',
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
          },
        ),
      ),
      // display the trips
      body: SingleChildScrollView(
        child: SafeArea(
          child: tripsProvider.tripList.isNotEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tripsProvider.tripList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(tripsProvider.tripList[index].isBookmarked);
                        if (tripsProvider.tripList[index].isBookmarked) {
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
                              const SizedBox(height: 10),
                            ],
                          );
                        }else{
                          return Column(children: [SizedBox(height:0,),],);
                        }
                      },
                    ),
                  ],
                )
              : SizedBox(
                height:screenHeight-200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'No trips in wishlist.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.grey[300]
                                : Colors.grey[700],
                            fontFamily: 'ProductSans'),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
