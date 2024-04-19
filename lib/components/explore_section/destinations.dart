import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/places.dart';
import 'package:voyager/pages/explore_sections/destination_description.dart';
import 'package:voyager/utils/constants.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class Destinations extends StatelessWidget {
  final String place;
  const Destinations({
    super.key,
    required this.screenWidth,
    required this.place,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      margin: const EdgeInsets.all(3),
      child: Card(
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Bounceable(
          onTap: () {
            Future.delayed(const Duration(milliseconds: 250), () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DestDesc(
                    place: place,
                  ),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(
                        0.0, 1.0); // Start animation from bottom of the card
                    var end =
                        Offset.zero; // End animation at the top of the screen
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
                  CachedNetworkImage(
                    imageUrl: placeImgURL[place] as String,
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
                            place,
                            style: const TextStyle(
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
