import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voyager/auth/verify_email.dart';
import 'package:voyager/home_screen.dart';
import 'login_or_register.dart';

class MainPage extends StatelessWidget {
  bool isRegistered = false;

  MainPage({Key? key, required this.isRegistered}) : super(key: key);

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
            if (snapshot.data!.emailVerified == true) {
              return HomeScreen();
            } else {
              return const VerifyEmailPage();
            }
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
          // Default return statement
          return const LoginOrRegister();
        },
      ),
    );
  }
}
