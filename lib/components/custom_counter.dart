// ignore_for_file: camel_case_types

import 'package:customizable_counter/customizable_counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class customCounter extends StatefulWidget {
  const customCounter({super.key});

  @override
  State<customCounter> createState() => _customCounterState();
}

class _customCounterState extends State<customCounter> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return CustomizableCounter(
      borderWidth: 1,
      showButtonText: false,
      count: 1,
      step: 1,
      minCount: 1,
      incrementIcon: Icon(
        Icons.add,
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.white
            : Colors.black,
      ),
      decrementIcon: Icon(
        Icons.remove,
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.white
            : Colors.black,
      ),
      onCountChange: (count) {},
      onIncrement: (count) {},
      onDecrement: (count) {},
    );
  }
}
