// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class CatIcon extends StatelessWidget {
  late Icon icon;
  late String text;
  CatIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: 90,
      height: 105,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.grey[900]
                    : Colors.grey[100],
              ),
              child: icon,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                text,
                maxLines: 3,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
