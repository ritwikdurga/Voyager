// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class FriendsIcons extends StatelessWidget {
  const FriendsIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 15,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, index) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                _showNameContainer(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[800],
                ),
                child: Center(
                  child: Text('N',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                ),
              ),
            ),
            if (index != 14)
              SizedBox(
                width: 8,
              ),
          ],
        );
      },
    );
  }
}

void _showNameContainer(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.white
          : Colors.black,
      content: Center(
        child: Text(
          'Nithin',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w500,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      duration: Duration(seconds: 2),
    ),
  );
}