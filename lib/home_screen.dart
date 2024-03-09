// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group9_auth/pages/add_trips_page.dart';
import 'package:group9_auth/pages/booking_page.dart';
import 'package:group9_auth/pages/explore_page.dart';
import 'package:group9_auth/pages/profile_page.dart';
import 'package:group9_auth/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int myIndex=0;
  List<Widget> widgetList=[
    Explore(),
    Booking(),
    AddTrips(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: IndexedStack(
          index: myIndex,
          children: widgetList,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black, 
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            setState(() {
              myIndex=index;
            });
          },
          currentIndex: myIndex,
          showUnselectedLabels: false,
          selectedItemColor: kGreenColor,
          unselectedItemColor: Colors.grey[600],
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label:'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.confirmation_num_outlined,
              ),
              label:'Booking'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.mode_of_travel_outlined,
              ),
              label: 'Add trips',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
