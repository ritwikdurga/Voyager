// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/painting.dart";
import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/category_icon.dart";
import "package:voyager/components/explore_section/category_icons_listview.dart";
import "package:voyager/components/explore_section/destinations.dart";
import "package:voyager/components/explore_section/image_slider.dart";
import "package:voyager/components/explore_section/travel_info_list.dart";
import "package:voyager/pages/explore_sections/for_you_expanded.dart";
import "package:voyager/pages/explore_sections/see_all_for_categories.dart";
import "package:voyager/utils/colors.dart";
import "package:voyager/utils/constants.dart";

class DestDesc extends StatefulWidget {
  const DestDesc({super.key});

  @override
  State<DestDesc> createState() => _DestDescState();
}

class _DestDescState extends State<DestDesc> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Paris',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenWidth,
                child: ComplicatedImage(ImgList: imgList),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'About this Place',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Paris, the cosmopolitan capital of France, is one of the largest agglomerations in Europe, with 2.2 million people living in the dense (105 km2) central city in 2022, 10 million people in the Métropole du Grand Paris (814 km2) and almost 13 million people living in the metropolitan area. Paris is amazing and lovely.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 12),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0,12,12,1),
                    child: Text(
                      'Travel information',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 105,
                child: TravelInfoList(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical:0.5, horizontal: 12),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Text(
                            'See All',
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 10,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // show a popup with all the categories listed.
                      showModalBottomSheet<void>(
                        context: context,
                        useSafeArea: true,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return bottomSheet();
                        },
                      );
                    },
                  ),
                ],
              ),
              // SizedBox(
              //   height: 3,
              // ),
              SizedBox(
                height: 105,
                child: CatIconsListView(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 12),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Text(
                      'Top Attractions',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: themeProvider.themeMode == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForYouExp(heading: 'Top Attractions')));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 6.5,
              ),
              SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                      Destinations(screenWidth: screenWidth),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
