// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:group9_auth/auth/login_or_register.dart';

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
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
      ],
    ).animate(_controller);

    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
      ],
    ).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: _topAlignmentAnimation.value,
                      end: _bottomAlignmentAnimation.value,
                      colors: [
                        Colors.greenAccent,
                        Colors.white60,
                        Colors.black45,
                      ],
                    ),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Text(
                        'Lets Plan Your Trip!',
                        style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'ProductSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150, // Adjust the width as per your requirement
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginOrRegister()));

                          // Navigate to the second screen using a named route.
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5, // Add shadow elevation
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25), // Button border radius
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 150, // Adjust the width as per your requirement
                      child: ElevatedButton(
                        onPressed: () {
                          // check if user is logged in or not
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginOrRegister(noReg: true)));
                          // Navigate to the second screen using a named route.
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5, // Add shadow elevation
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25), // Button border radius
                          ),
                        ),
                        child: Text(
                          'Signup',
                          style: TextStyle(fontSize: 18),
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
          ],
        ),
      ),
    );
  }
}
