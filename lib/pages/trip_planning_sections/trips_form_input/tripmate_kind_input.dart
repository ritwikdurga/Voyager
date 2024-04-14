// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class TripMateKind extends StatefulWidget {
  final Function(String?)? onTripMateSelected;
  const TripMateKind({Key? key, this.onTripMateSelected}) : super(key: key);

  @override
  State<TripMateKind> createState() => _TripMateKindState();
}

class _TripMateKindState extends State<TripMateKind>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int selectedContainerIndex = -1;
  List<String> tripMatekinds = ['Going solo', 'Partner', 'Friends', 'Family'];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text(
          'Who\'s coming with you?',
          style: TextStyle(
            fontFamily: 'ProductSans',
            fontSize: 24,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose One',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(
                  0,
                  screenWidth,
                  Icon(Iconsax.user, size: 30),
                  'Going solo',
                  themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                buildContainer(
                  1,
                  screenWidth,
                  Icon(Iconsax.profile_2user, size: 30),
                  'Partner',
                  themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildContainer(
                  2,
                  screenWidth,
                  Row(
                    children: [
                      Icon(Iconsax.profile_2user, size: 30),
                      Icon(Iconsax.profile_2user, size: 30),
                    ],
                  ),
                  'Friends',
                  themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                buildContainer(
                  3,
                  screenWidth,
                  Icon(Iconsax.user_octagon, size: 30),
                  'Family',
                  themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget buildContainer(
      int index, double screenWidth, Widget icon, String str, Color colour) {
        final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedContainerIndex == index) {
            selectedContainerIndex = -1;
            widget.onTripMateSelected!(null);
          } else {
            selectedContainerIndex = index;
            widget.onTripMateSelected!(tripMatekinds[selectedContainerIndex]);
          }
        });
      },
      child: Container(
        width: screenWidth / 2 - 15,
        height: screenWidth / 3,
        decoration: BoxDecoration(
          border: Border.all(
            color: themeProvider.themeMode == ThemeMode.dark
            ? selectedContainerIndex == index
                ? Colors.grey.shade400
                : Colors.grey.shade900
            : selectedContainerIndex == index
                ? Colors.grey.shade900
                : Colors.grey.shade400,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              Spacer(),
              Text(
                str,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                  color: colour,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
