// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/components/explore_section/category_icon.dart';
import 'package:voyager/utils/constants.dart';

class CatIconsListView extends StatelessWidget {
  final List<Map<String, dynamic>> iconsData = Categories;

  CatIconsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: iconsData.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
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
        );
      },
    );
  }
}
