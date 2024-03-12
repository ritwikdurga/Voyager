import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voyager/utils/constants.dart';

import '../home_screen.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

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
      successSnackBar();

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

  void successSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // Change the background color of the snackbar
        backgroundColor: Colors.green,
        content: Center(
          child: Text(
            'Account created successfully!',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
              fontWeight: FontWeight.w600, // Change the font weight as needed
            ),
          ),
        ),
      ),
    );
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
  Widget build(BuildContext context) => PopScope(
    canPop: false, // Disable back button
    child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Verify Email',
          style: TextStyle(
            color: kGreenColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'An email has been sent to your email address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Please verify',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 3, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 0), // Offset in x and y directions
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  await sendVerificationEmail();
                },
                style: ElevatedButton.styleFrom(
                  // You can customize the button's appearance here
                  foregroundColor: kGreenColor,
                  backgroundColor: Colors.white, // Text color
                ),
                child: const Text(
                  'Resend email',
                  style: TextStyle(
                    color: kGreenColor,
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 3, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, 0), // Offset in x and y directions
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  // Delete the user account if created
                  await FirebaseAuth.instance.currentUser!.delete();
                  // Go back to the login page
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  // You can customize the button's appearance here
                  foregroundColor: kGreenColor,
                  backgroundColor: Colors.white, // Text color
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: kGreenColor,
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