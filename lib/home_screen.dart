import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/explore_sections/explore_page.dart';
import 'package:voyager/pages/profile_sections/profile_page.dart';
import 'package:voyager/pages/search_sections/search_page.dart';
import 'package:voyager/pages/trip_planning_sections/add_trips_page.dart';
import 'package:voyager/utils/constants.dart';

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
    final isKeyboardOpen = WidgetsBinding.instance?.window.viewInsets.bottom != 0;
    setState(() {
      isKeyboardVisible = isKeyboardOpen;
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
                      Iconsax.search_status,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Iconsax.route_square,
                    ),
                    label: 'Trips',
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
          : null,
    );
  }
}
