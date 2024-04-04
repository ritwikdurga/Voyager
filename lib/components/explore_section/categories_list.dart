// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/pages/explore_sections/category_page.dart';
import 'package:voyager/utils/constants.dart';

class CatListTile extends StatelessWidget {
  late Icon icon;
  late String text;
  late String category_id;
  CatListTile({super.key, required this.icon, required this.text,required this.category_id,});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      child: SizedBox(
        width: screenWidth,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //color: Colors.amber,
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey[900]
                      : Colors.grey[100],
                ),
                child: icon,
              ),
            ),
            SizedBox(width: 5),
            Text(text,
                style: TextStyle(
                  fontSize: 18,
                )),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryPage(heading: text,category_id: category_id,)));
      },
    );
  }
}
