// this is to check if the user is logged in or not
// if the user is logged in, then the user will be redirected to the home page
// if the user is not logged in, then the user will be redirected to the login page

// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group9_auth/auth/verify_email.dart';
import 'package:group9_auth/home_screen.dart';
import 'login_or_register.dart';

class MainPage extends StatelessWidget {
  bool isRegistered = false;

  MainPage({super.key, required this.isRegistered});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          if (isRegistered == true) {
            return const VerifyEmailPage();
          }
          return HomeScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        } else {
          return const LoginOrRegister();
        }
      },
    ));
  }
}
