// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/profile_sections/faq_page.dart';
import 'package:voyager/pages/profile_sections/favourite_page.dart';
import 'package:voyager/pages/profile_sections/feedback_page.dart';
import 'package:voyager/pages/profile_sections/trips_page.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import 'edit_profile_page.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? darkColorScheme.background
          : lightColorScheme.background,
      appBar: AppBar(
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
        title: Text('Profile Page',
            style: TextStyle(
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'ProductSans')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: themeProvider.themeMode == ThemeMode.dark
                ? Icon(
                    Icons.light_mode,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.dark_mode,
                    color: Colors.black,
                  ),
            onPressed: () {
              themeProvider.setThemeMode(
                  themeProvider.themeMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // profile photo section
              SizedBox(
                height: 30,
              ),
              // editable profile name section
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'John Doe',
                    style: TextStyle(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ProductSans'),
                  ),
                ),
              ),

              // information about when the user joined
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Center(
                  child: Text(
                    'Joined in 2023',
                    // You can replace this with the actual date joined
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                        fontFamily: 'ProductSans'),
                  ),
                ),
              ),

              Center(
                child: SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      // Change text color
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(25)), // Rounded corners
                    ),
                    child: Text('Edit Profile'),
                  ),
                ),
              ),
              SizedBox(height: 25),
              // Clickable tiles
              ListTile(
                // icon for trips
                leading: Container(
                  child: Icon(
                    Iconsax.map,
                    size: 30,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  decoration: BoxDecoration(),
                ),
                title: Text('My Trips',
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                onTap: () {
                  // Navigate to Trips page
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileTrips()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),

              ListTile(
                leading: Icon(
                  Icons.favorite,
                  size: 30,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text('Wishlist',
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FavouritePage()));
                  // Navigate to Wishlist page
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  size: 30,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text('FAQ',
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                onTap: () {
                  // Navigate to FAQ page
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FAQPage();
                  }));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  size: 30,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text('About',
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                onTap: () {
                  // Navigate to About page
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              // feedback
              ListTile(
                leading: Icon(
                  Icons.feedback,
                  size: 30,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text('Feedback',
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()));
                  // Navigate to Feedback page
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 40,
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Voyager',
                    style: TextStyle(
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                        fontFamily: 'ProductSans',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'v1.0', // Your app version number
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontFamily: 'ProductSans'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
