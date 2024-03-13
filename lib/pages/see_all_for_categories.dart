// ignore_for_file: camel_case_types, prefer_const_constructors, use_super_parameters, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/categories_listview.dart';
import 'package:voyager/utils/constants.dart';

class bottomSheet extends StatefulWidget {
  const bottomSheet({
    super.key,
  });

  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  late List<Map<String, dynamic>> iconsData;
  late TextEditingController controller;

  @override
  void initState() {
    iconsData = Categories;
    controller = TextEditingController();
    super.initState();
  }

  void searchCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        iconsData = Categories;
      } else {
        iconsData = Categories.where((category) =>
                category['text'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SingleChildScrollView(
      child: Container(
        color: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        child: SizedBox(
          height: 0.8 * screenHeight,
          width: screenWidth,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                0.05 * screenWidth, 0.02 * screenHeight, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 0.8 * screenWidth,
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          hintText: 'Categories',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        onChanged:
                            searchCategories,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: CatList(
                    iconsData: iconsData,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
