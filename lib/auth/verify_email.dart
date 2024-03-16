import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/colors.dart';
import 'package:voyager/utils/constants.dart';

import '../home_screen.dart';
import '../pages/login_section/login_page.dart';

class VerifyEmailPage extends StatefulWidget {
  final Function()? onTap;

  const VerifyEmailPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isEmailVerified = user.emailVerified;

      if (!isEmailVerified) {
        sendVerificationEmail();

        timer = Timer.periodic(Duration(seconds: 2), (_) {
          checkEmailVerified();
        });
      }
    }
  }

  Future<void> checkEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      timer?.cancel();
      setState(() {
        isEmailVerified = true;
      });

      // Create the user account after email verification
      await createUserAccount();

      // Navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  Future<void> createUserAccount() async {
    // Get user information
    User? user = FirebaseAuth.instance.currentUser;

    // Create the user account in your database or perform any other required tasks
    // For example, you can create a user document in Firestore

    // Example:
    // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    //   'email': user.email,
    //   // Add other user details if needed
    // });
  }

  Future<void> sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on Exception catch (e) {
      // show error as a snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return PopScope(
      canPop: false, // Disable back button
      child: Scaffold(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        appBar: AppBar(
          backgroundColor: themeProvider.themeMode == ThemeMode.dark
              ? darkColorScheme.background
              : lightColorScheme.background,
          title: Text(
            'Verify Email',
            style: TextStyle(
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'An email has been sent to your email address',
                style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please verify',
                style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await sendVerificationEmail();
                  },
                  style: ElevatedButton.styleFrom(
                    // You can customize the button's appearance here
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent, // Text color
                  ),
                  child: const Text(
                    'Resend email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Add a cancel button to cancel the verification and go back to the login page
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => LoginPage(onTap: widget.onTap)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // You can customize the button's appearance here
                    foregroundColor: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    backgroundColor: Colors.blueAccent, // Text color
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
