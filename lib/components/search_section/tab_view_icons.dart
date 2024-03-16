// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class TabViewIcon extends StatelessWidget {
  late IconData icon;
  late String text;
  final bool rightDivider;
  TabViewIcon({
    super.key,
    required this.icon,
    required this.text,
    required this.rightDivider,
  });
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Tab(
      icon: Icon(
        icon,
        size: 30,
      ),
      height: 60,
      text: text,
      iconMargin: EdgeInsets.all(5),
    );
  }
}
