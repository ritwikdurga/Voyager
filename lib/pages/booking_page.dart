import 'package:flutter/material.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          // text widget
          child: Center(
            child: Text('Booking',
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