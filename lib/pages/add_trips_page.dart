import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';

class AddTrips extends StatelessWidget {
  const AddTrips({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      body: SafeArea(
        // text widget
        child: Center(
          child: Text('Add Trips',
              style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                fontSize: 30,
              )),
        ),
      ),
    );
  }
}
