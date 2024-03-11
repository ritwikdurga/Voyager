// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:group9_auth/pages/add_trips_page.dart';
import 'package:group9_auth/pages/booking_page.dart';
import 'package:group9_auth/pages/explore_page.dart';
import 'package:group9_auth/pages/profile_page.dart';
import 'package:group9_auth/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int myIndex=0;
  List<Widget> widgetList=[
    Explore(),
    Booking(),
    AddTrips(),
    Profile(),
  ];
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance?.window.viewInsets.bottom ?? 0.0;
    setState(() {
      isKeyboardVisible = bottomInset > 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:Center(
        child: IndexedStack(
          index: myIndex,
          children: widgetList,
        ),
      ),
      resizeToAvoidBottomInset:false,
      bottomNavigationBar: !isKeyboardVisible
      ? Theme(
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
          selectedLabelStyle: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w600,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home,
              ),
              label: 'Explore',
              // style the label
      
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.airplane_square,
              ),
              label:'Booking'
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.route_square,
              ),
              label: 'Add trips',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.user,
              ),
              label: 'Profile',
            ),
          ],
        ),
      )
      :null
    );
  }
}
