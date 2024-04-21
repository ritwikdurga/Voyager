// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:voyager/components/explore_section/category_icon.dart';
import 'package:voyager/pages/explore_sections/category_page.dart';
import 'package:voyager/utils/constants.dart';

class CatIconsListView extends StatelessWidget {
  final List<Map<String, dynamic>> iconsData = Categories;
  final String place;
  CatIconsListView({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: iconsData.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                children: [
                  CatIcon(
                    icon: Icon(iconsData[index]['icon'], size: 25),
                    text: iconsData[index]['text'],
                  ),
                  if (index != iconsData.length - 1)
                    SizedBox(
                        width: 5,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 34.0),
                          child: VerticalDivider(
                            thickness: 0.25,
                          ),
                        )),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryPage(
                          place: place,
                          heading: iconsData[index]['text'],
                          category_id: iconsData[index]['category_id'])));
            });
      },
    );
  }
}
