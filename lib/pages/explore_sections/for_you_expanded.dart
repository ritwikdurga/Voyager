// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/destinations_expanded.dart";
import "package:voyager/utils/colors.dart";
import "package:voyager/utils/constants.dart";

class ForYouExp extends StatefulWidget {
  late String heading;
  ForYouExp({super.key, required this.heading});

  @override
  State<ForYouExp> createState() => _ForYouExpState();
}

class _ForYouExpState extends State<ForYouExp> {
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
          widget.heading,
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
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
            destExp(screenWidth: screenWidth),
            SizedBox(height: 10),
          ],
        )),
      ),
    );
  }
}
