// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group9_auth/components/back_ground/animatedbck.dart';
import 'package:group9_auth/components/my_button.dart';
import 'package:group9_auth/components/third_party.dart';
import 'package:group9_auth/services/auth_service.dart';

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
  final TextEditingController _enterPasswordController =
      TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

  Future<void> _signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Loading(),
    );

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _enterPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
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
        successSnackBar();
        // Close the dialog
        if (mounted) {
          Navigator.pop(context);
        }
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          Navigator.pop(context);
        }
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
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'Account created successfully!',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
            ),
          ),
        ),
      ),
    );
  }

  void errorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'An error occurred. Please try again later.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
            ),
          ),
        ),
      ),
    );
  }

  void passMismatch() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'Passwords doesnt match.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
            ),
          ),
        ),
      ),
    );
  }

  void emailInUse() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'The account already exists for that email.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
            ),
          ),
        ),
      ),
    );
  }

  void weakPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'The password provided is too weak.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
            ),
          ),
        ),
      ),
    );
  }

  void emptyFields() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'All fields are required.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the font color as needed
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
                      "New to Voyager?",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Let's get you started!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        )),
                    SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 2.5),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: "ProductSans",
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 2.5),
                          child: TextField(
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              color: Colors.black,
                              fontSize: 18,
                            ),
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontFamily: "ProductSans",
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 8.0, bottom: 2.5),
                          // Added right padding for the IconButton

                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  controller: _enterPasswordController,
                                  obscureText: !_isEnterPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Enter Password",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: "ProductSans",
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _isEnterPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: _toggleEnterPasswordVisibility,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 8.0, bottom: 2.5),
                          // Added right padding for the IconButton
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  controller: _confirmPasswordController,
                                  obscureText: !_isConfirmPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontFamily: "ProductSans",
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: _toggleConfirmPasswordVisibility,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
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
                                color: kGreenColor,
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account? ",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "ProductSans",
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login Here",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              color: kGreenColor,
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
