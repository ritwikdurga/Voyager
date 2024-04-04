// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voyager/components/explore_section/categories_list.dart';
import 'package:voyager/components/explore_section/category_icon.dart';
import 'package:voyager/utils/constants.dart';

class CatList extends StatelessWidget {
  late List<Map<String, dynamic>> iconsData;
  CatList({super.key,required this.iconsData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: iconsData.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Icon(iconsData[index]['icon'], size: 50),
              //     Text(iconsData[index]['text']),
              //   ],
              // ),
              CatListTile(
                icon: Icon(iconsData[index]['icon'], size: 30),
                text: iconsData[index]['text'],
                category_id: iconsData[index]['category_id'],
              ),
              if (index != iconsData.length - 1)
                SizedBox(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Divider(
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
