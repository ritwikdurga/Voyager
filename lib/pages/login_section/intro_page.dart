// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/auth/login_or_register.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../../utils/circular_animator.dart';
import '../../utils/constants.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: IntroPage(),
  ));
}

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                    child: CircularAnimator(
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white),
                        child: Icon(
                          Icons.travel_explore,
                          color: Colors.blueAccent,
                          size: 60,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Voyager',
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: GoogleFonts.pacifico().fontFamily,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Explore, Plan, Experience',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.bold,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.grey[400]
                        : Colors.grey[700],
                  ),
                ),
              ],
            ),


            SizedBox(
              height: 50,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130, // Adjust the width as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginOrRegister()));

                      // Navigate to the second screen using a named route.
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                      elevation: 10,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25), // Button border radius
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 130, // Adjust the width as per your requirement
                  child: ElevatedButton(
                    onPressed: () {
                      // check if user is logged in or not
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginOrRegister(noReg: true)));
                      // Navigate to the second screen using a named route.
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                      elevation: 10,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            25), // Button border radius
                      ),
                    ),
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )

            // SizedBox(
            //   width: 200, // Adjust the width as per your requirement
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigate to the second screen using a named route.
            //     },
            //     style: ElevatedButton.styleFrom(
            //       elevation: 5, // Add shadow elevation
            //       padding: EdgeInsets.symmetric(vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius:
            //             BorderRadius.circular(25), // Button border radius
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Get Started',
            //           style: TextStyle(fontSize: 18),
            //         ),
            //         SizedBox(width: 10),
            //         // Space between text and arrow icon
            //         Icon(Icons.arrow_forward)
            //         // Arrow icon
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
