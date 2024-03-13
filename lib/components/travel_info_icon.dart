// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/travel_info_page.dart';
import 'package:voyager/utils/constants.dart';

class TravelInfoIcon extends StatelessWidget {
  late Icon icon;
  late String text;
  TravelInfoIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: SizedBox(
        width: screenWidth/5-4,
        height: 105,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenWidth/5-4,
                width: 60,
                child: icon,
              ),
              SizedBox(
                height: 2,
              ),
              Center(
                child: Text(
                  text,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TravelInfoPage(heading: text)));
      },
    );
  }
}
