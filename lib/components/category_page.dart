// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class CategoryPage extends StatelessWidget {
  late String heading;
  CategoryPage({super.key, required this.heading});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(heading),
          backgroundColor: themeProvider.themeMode == ThemeMode.dark
              ? Colors.black
              : Colors.white,
        ),
        body: Center(
          child: Text('random.'),
        ));
  }
}
