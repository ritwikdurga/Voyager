// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/components/explore_section/category_icons_listview.dart";
import "package:voyager/components/explore_section/destinations.dart";
import "package:voyager/components/explore_section/destinations_expanded.dart";
import "package:voyager/components/explore_section/image_slider.dart";
import "package:voyager/components/explore_section/places.dart";
import "package:voyager/components/explore_section/travel_info_list.dart";
import "package:voyager/pages/explore_sections/destination_top_attractions.dart";
import "package:voyager/pages/explore_sections/for_you_expanded.dart";
import "package:voyager/pages/explore_sections/see_all_for_categories.dart";
import "package:voyager/utils/constants.dart";

class DestDesc extends StatefulWidget {
  final String place;
  const DestDesc({super.key, required this.place});

  @override
  State<DestDesc> createState() => _DestDescState();
}

class _DestDescState extends State<DestDesc> {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = destImg[widget.place] as List<String>;
    double screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.place,
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
                  descrption[widget.place] ?? "",
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
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
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
                height: 90,
                child: TravelInfoList(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 12),
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
                              builder: (context) => DestTopAttExp(
                                    heading: 'Top Attractions',
                                    place: widget.place,
                                  )));
                    },
                  )
                ],
              ),
              SizedBox(
                height: 6.5,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: attractions[widget.place]!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return destExp(
                    //   place: places[index],
                    //   screenWidth: screenWidth,
                    // );
                    return Card(
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
                                  placeImgURL[attractions[widget.place]![index]]
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
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
