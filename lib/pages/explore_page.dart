// ignore_for_file:  prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:group9_auth/components/search_bar.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Search(),
              Text("Explore",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}