// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Iconsax.logout, color: Colors.white,),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        // text widget
        child: Center(
          child: Text('Profile',
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