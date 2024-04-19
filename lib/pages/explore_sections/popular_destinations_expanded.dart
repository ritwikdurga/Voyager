// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/destinations_expanded.dart";
import "package:voyager/components/explore_section/places.dart";
import "package:voyager/utils/colors.dart";
import "package:voyager/utils/constants.dart";

class PopDestExp extends StatefulWidget {
  const PopDestExp({super.key});

  @override
  State<PopDestExp> createState() => _PopDestExpState();
}

class _PopDestExpState extends State<PopDestExp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 20,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Popular Destinations',
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      destExp(place: places[index], screenWidth: screenWidth),
                      SizedBox(height: 10),
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
