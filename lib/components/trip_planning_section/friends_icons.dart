// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/utils/constants.dart';

class FriendsIcons extends StatelessWidget {
  FriendsIcons({super.key});
  String photoURL =
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 15,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, index) {
        if (index == 0) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Send Invitation'),
                          content: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter your friend\'s email address',
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Send Invitation'),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: kGreenColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          );
        }
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                _showNameContainer(context);
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(photoURL),
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
