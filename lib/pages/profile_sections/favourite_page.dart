import 'package:flutter/material.dart';

import '../../components/trips_cards.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Wishlist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'ProductSans')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Add functionality here to navigate back
            // For example: Navigator.pop(context);
          },
        ),
      ),
      // display the trips
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // display the trips
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
              SizedBox(height: 10),
              trips(screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }
}
