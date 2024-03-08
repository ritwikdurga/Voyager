import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
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
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                    "We'll send you an email with a link to reset your password"),

                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",

                    ),
                  ),
                ),
                SizedBox(height: 20),
                // add send email and then back button to the login page
                SizedBox(
                  width: 150, // Adjust the width as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      passwordReset();
                    },
                    style: ElevatedButton.styleFrom(
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
                SizedBox(height: 20),
                SizedBox(
                  width: 150, // Adjust the width as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
