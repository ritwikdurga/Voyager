// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../utils/constants.dart";

class PastSearches extends StatelessWidget {
  const PastSearches({
    super.key,
    required this.textData,
  });

  final textData;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      color: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      surfaceTintColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: () {
          //searchState.performSearch("Search Term");
          debugPrint(textData);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
          child: Text(
            textData,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
