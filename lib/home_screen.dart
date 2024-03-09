// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.black,
        // logout button
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen ${user!.email}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
