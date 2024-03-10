import 'package:flutter/material.dart';

class AddTrips extends StatelessWidget {
  const AddTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        // text widget
        child: Center(
          child: Text('Add Trips',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              )

          ),
        ),
      ),
    );
  }
}