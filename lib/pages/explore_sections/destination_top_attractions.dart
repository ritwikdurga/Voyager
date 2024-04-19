// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/places.dart";
import "package:voyager/utils/colors.dart";
import "package:voyager/utils/constants.dart";

class DestTopAttExp extends StatefulWidget {
  late String heading;
  late String place;
  DestTopAttExp({super.key, required this.heading, required this.place});

  @override
  State<DestTopAttExp> createState() => _DestTopAttExpState();
}

class _DestTopAttExpState extends State<DestTopAttExp> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.white
                : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.heading,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? darkColorScheme.background
            : lightColorScheme.background,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? kBlackColor
                            : Colors.grey.shade200,
                        surfaceTintColor:
                            themeProvider.themeMode == ThemeMode.dark
                                ? kBlackColor
                                : Colors.grey.shade200,
                        elevation: 0,
                        child: SizedBox(
                          height: screenWidth / 3,
                          width: screenWidth - 10,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(18, 8, 0, 8),
                            child: Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: (screenWidth / 3) - 16,
                                    maxWidth: screenWidth / 3,
                                  ),
                                  child: Image.network(
                                    placeImgURL[
                                            attractions[widget.place]![index]]
                                        as String,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth / 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      attractions[widget.place]![index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 24,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    SizedBox(height: 0.25),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: screenWidth / 2),
                                      child: Text(
                                        attDes[attractions[widget.place]![
                                                index]] ??
                                            '',
                                        style: TextStyle(
                                          color: themeProvider.themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
