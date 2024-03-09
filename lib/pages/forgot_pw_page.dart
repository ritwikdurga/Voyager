// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group9_auth/utils/constants.dart';
import '../components/back_ground/animatedbck.dart';
import '../components/loading.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    showDialog(context: context, builder: (context) => Loading());
    try {
      // check for empty email
      if (_emailController.text.trim().isEmpty) {
        Navigator.pop(context);
        emptyEmail();
        return;
      }
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      emailSent();
      if(mounted){
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if(mounted){
        Navigator.pop(context);
      }
      if (e.code == 'user-not-found') {
        userNotFound();
      }
      if (e.code == 'invalid-email') {
        invalidEmail();
      }
    }
  }

  void emailSent() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Center(
          child: Text(
            'Email sent successfully. Check your inbox!',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void invalidEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Center(
          child: Text(
            'Please enter a valid email',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void emptyEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'Please enter an email',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void userNotFound() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Center(
          child: Text(
            'No user found for that email',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          animatedBck(), // Corrected function call
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    "We'll send you an email with a link to reset your password",
                    style: TextStyle(
                      color: Colors.white,
                    ) ,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // add send email and then back button to the login page
                SizedBox(
                  width: 150, // Adjust the width as per your requirement
                  child: Container(
                    // add box shadow
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.7),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        passwordReset();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: kGreenColor, backgroundColor: kBlackColor, // foreground
                        elevation: 5, // Add shadow elevation
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25), // Button border radius
                        ),
                      ),

                      child: Text(
                        'Send Email',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Space between text and arrow icon
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 150, // Adjust the width as per your requirement
                  child: Container(
                    // add box shadow
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.7),
                          spreadRadius: 4,
                          blurRadius: 5,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                        foregroundColor: kGreenColor, backgroundColor: kBlackColor,
                        elevation: 5, // Add shadow elevation
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25), // Button border radius
                        ),
                      ),

                      child: Text(
                        'Back',
                        style: TextStyle(fontSize: 18),
                      ),
                      // Space between text and arrow icon
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
