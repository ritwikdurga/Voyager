// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/pages/destination_description.dart";
import "package:voyager/utils/constants.dart";

class Destinations extends StatelessWidget {
  const Destinations({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.all(3),
      child: Card(
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: () {
            //redirect to trip page
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DestDesc()));
          },
          child: SizedBox(
            width: screenWidth / 3 - 12,
            height: screenWidth * 2 / 3,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: screenWidth / 2,
                        maxWidth: screenWidth / 3 - 20,
                      ),
                      child: Image.asset(
                        'assets/images/a.png',
                      )),
                ),
                Text(
                  'Paris',
                  style: TextStyle(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
