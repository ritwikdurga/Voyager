// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/utils/constants.dart";

import "../../utils/colors.dart";

class trips extends StatelessWidget {
  trips({
    super.key,
    required this.screenWidth,
  });

  final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: shape,
      color: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      surfaceTintColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      elevation: 0,
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: () {
          // redirect to planning page.
        },
        child: SizedBox(
          height: screenWidth / 3 + 20,
          width: screenWidth - 10,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/a.png',
                fit: BoxFit.cover,
                height: screenWidth / 3 + 20,
                width: screenWidth - 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '31 Mar - 4 Apr',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Paris Trip',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
