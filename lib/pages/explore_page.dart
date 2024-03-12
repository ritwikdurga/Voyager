// ignore_for_file:  prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/destinations.dart';
import 'package:voyager/components/past_searches.dart';
import 'package:voyager/components/search_bar.dart';
import 'package:voyager/components/trips_cards.dart';
import 'package:voyager/utils/constants.dart';

import '../utils/colors.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      body: SingleChildScrollView(
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Search(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'Continue Planning',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                  height: screenWidth / 3 + 20,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      trips(screenWidth: screenWidth),
                      trips(screenWidth: screenWidth),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'For You',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                      ],
                    )),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'Your Searches',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                  height: 45,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    PastSearches(
                      textData: 'item 0',
                    ),
                    PastSearches(
                      textData: 'item 1',
                    ),
                    PastSearches(
                      textData: 'item 2',
                    ),
                  ]),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                      child: Text(
                        'Popular Destinations',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6.5,
                ),
                SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                        Destinations(screenWidth: screenWidth),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
