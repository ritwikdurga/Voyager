// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/trip_planning_sections/add_trips_page.dart';
import 'package:voyager/pages/booking_sections/booking_page.dart';
import 'package:voyager/pages/explore_sections/explore_page.dart';
import 'package:voyager/pages/profile_sections/profile_page.dart';
import 'package:voyager/utils/constants.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  late MyIndexProvider _indexProvider;
  late int myIndex = _indexProvider.myIndex;
  List<Widget> widgetList = [
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
    _indexProvider = Provider.of<MyIndexProvider>(context, listen: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset =
        WidgetsBinding.instance?.window.viewInsets.bottom ?? 0.0;
    setState(() {
      isKeyboardVisible = bottomInset > 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        body: Center(
          child: Consumer<MyIndexProvider>(
            builder: (context, indexProvider, _) {
              return IndexedStack(
                index: indexProvider.myIndex,
                children: widgetList,
              );
            },
          ),
        ),
        bottomNavigationBar: !isKeyboardVisible
            ? Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.black
                      : Colors.white,
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    setState(() {
                      myIndex = index;
                      _indexProvider.setMyIndex(index);
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
                        label: 'Booking'),
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
            : null);
  }
}
