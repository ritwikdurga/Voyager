import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group9_auth/components/back_ground/animatedbck.dart';
import 'package:group9_auth/components/my_button.dart';
import 'package:group9_auth/components/third_party.dart';
import 'package:group9_auth/services/auth_service.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math' as math;

import '../components/loading.dart';
import '../utils/constants.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _enterPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // password visibility flags
  bool _isEnterPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // toggle password visibility for entering password
  void _toggleEnterPasswordVisibility() {
    setState(() {
      _isEnterPasswordVisible = !_isEnterPasswordVisible;
    });
  }

  // toggle password visibility for confirming password
  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }


  void _signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Loading(),
    );

    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _enterPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      if (mounted) {
        Navigator.pop(context);
      }
      emptyFields();
      return;
    }

    // Check if the passwords match
    if (_enterPasswordController.text == _confirmPasswordController.text) {
      try {
        // Create the user with email, password, and display name
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _enterPasswordController.text,
        );
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;
        // set the users display name
        user!.updateDisplayName(_nameController.text);
          // Show a snackbar
          successSnackBar();
          // Close the dialog
          Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
          Navigator.pop(context);
        if (e.code == 'weak-password') {
          weakPassword();
        } else if (e.code == 'email-already-in-use') {
          emailInUse();
        }
      }
    } else {
      passMismatch();
    }
  }


  void successSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'Account created successfully!',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void errorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void passMismatch() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'Passwords donot match.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }


  void emailInUse() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'The account already exists for that email.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void weakPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'The password provided is too weak.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void emptyFields() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            'All fields are required.',
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _enterPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          animatedBck(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's Create an Account for You!",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 8.0), // Added right padding for the IconButton
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _enterPasswordController,
                                  obscureText: !_isEnterPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _isEnterPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: _toggleEnterPasswordVisibility,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 8.0), // Added right padding for the IconButton
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_isConfirmPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: _toggleConfirmPasswordVisibility,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MyButton(onPressed: _signUp, text: "Register"),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: kPrimaryColor,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Or Continue With",
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       IconButton(
                    //         onPressed: () => AuthService().signInWithGoogle(),
                    //         icon: Icon(
                    //           Ionicons.logo_google,
                    //           size: 30,
                    //           color: kPrimaryColor,
                    //         ),
                    //       ),
                    //       SizedBox(width: 20),
                    //       IconButton(
                    //         onPressed: () {},
                    //         icon: Icon(
                    //           Ionicons.logo_facebook,
                    //           size: 30,
                    //           color: kPrimaryColor,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialAuth(
                          onPressGoogle: () {
                            AuthService().signInWithGoogle();
                          },
                          onPressApple: () {
                            // Sign in with apple
                          },
                        ),

                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "ProductSans",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Login Here",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
