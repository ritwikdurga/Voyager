import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/explore_sections/destination_description.dart';
import 'package:voyager/utils/constants.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart'; // Import Bounceable package

class Destinations extends StatelessWidget {
  const Destinations({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: EdgeInsets.all(3),
      child: Card(
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Bounceable(
          onTap: () {
            // Add a delay before navigating
            Future.delayed(Duration(milliseconds: 250), () {
              //redirect to trip page
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DestDesc(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = Offset(0.0, 1.0); // Start animation from bottom of the card
                    var end = Offset.zero; // End animation at the top of the screen
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );


            });
          },
          child: InkWell(
            splashColor: Colors.blueAccent,
            child: SizedBox(
              width: screenWidth / 3 - 12,
              height: screenWidth * 2 / 3,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/a.png',
                    width: screenWidth / 3 - 12,
                    height: screenWidth * 2 / 3,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Paris',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
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
      ),
    );
  }
}
