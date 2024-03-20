// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/back_ground/animatedbck.dart';
import 'package:voyager/components/loading.dart';
import 'package:voyager/components/auth_section/my_button.dart';
import 'package:voyager/pages/login_section/register_page.dart';
import 'package:voyager/services/auth_service.dart';
import 'package:iconsax/iconsax.dart';
import '../../components/auth_section/third_party.dart';
import '../../utils/constants.dart';
import 'forgot_pw_page.dart';
import 'package:voyager/pages/profile_sections/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // password visibility flag
  bool _isPasswordVisible = false;

  // toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Future<void> _signIn() async {
    // Show loading dialog
    showDialog(
      context: context,
      builder: (context) => Loading(),
    );

    try {
      if (_emailController.text.trim().isEmpty ||
          _passwordController.text.trim().isEmpty) {
        // Hide loading dialog
        Navigator.pop(context);

        // Show error message
        emptyFieldSnackBar();
        return;
      }
      // Sign in with email and password
      await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      FirebaseAuth instance = FirebaseAuth.instance;
      // ignore: use_build_context_synchronously
      Provider.of<UserProvider>(context, listen: false)
          .updateName(instance.currentUser?.displayName ?? 'NaN');

      // Hide loading dialog
      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Hide loading dialog
      if (mounted) {
        Navigator.pop(context);
      }
      if (e.code == 'user-not-found') {
        // give another method to show snackbar without the of(context)
        userNotFoundSnackBar();
      } else if (e.code == 'wrong-password') {
        wrongPasswordSnackBar();
        print(e.code);
      } else {
        errorSnackBar();
      }
    }
  }

  void emptyFieldSnackBar() {
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
              color: Colors.white, // Change the text color
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
              fontFamily: 'ProductSans',
              color: Colors.white, // Change the font family as needed
            ),
          ),
        ),
      ),
    );
  }

  void wrongPasswordSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'Wrong password provided for that user.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the text color
            ),
          ),
        ),
      ),
    );
  }

  void userNotFoundSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        // Change the background color of the snackbar

        content: Center(
          child: Text(
            'No User Found.',
            style: TextStyle(
              fontSize: 16, // Change the font size as needed
              fontFamily: 'ProductSans', // Change the font family as needed
              color: Colors.white, // Change the text color
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                      "Welcome to Voyager!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        // color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please sign in to access your account.",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 8.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.grey[800]
                              : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10, bottom: 6),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.5),
                                child: Icon(
                                  Iconsax.sms,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "ProductSans",
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.grey[800]
                              : Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10, bottom: 6, right: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6.5),
                                child: Icon(
                                  Iconsax.lock_1,
                                  color:
                                      themeProvider.themeMode == ThemeMode.dark
                                          ? Colors.white
                                          : Colors.black,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !_isPasswordVisible,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "ProductSans",
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash,
                                    color: Colors.grey,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to the forgot password screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPassword()));
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MyButton(onPressed: _signIn, text: "Login"),
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
                                color: themeProvider.themeMode == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
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
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SocialAuth(
                            onPressGoogle: () async {
                              await _authService.signInWithGoogle();
                              FirebaseAuth instance = FirebaseAuth.instance;
                              // ignore: use_build_context_synchronously
                              Provider.of<UserProvider>(context, listen: false)
                                  .updateName(
                                      instance.currentUser?.displayName ??
                                          'NaN');
                            },
                            onPressApple: () {
                              // Sign in with apple
                              AuthService().signInWithApple();
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
// send this row to the bottom of the screen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member? ",
                          style: TextStyle(
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                            fontFamily: "ProductSans",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Navigate to the SignUpPage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(onTap: widget.onTap)),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              color: Colors.blueAccent,
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
