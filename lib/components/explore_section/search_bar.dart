// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";
import "package:provider/provider.dart";
import "package:voyager/pages/explore_sections/destination_description.dart";
import "package:voyager/utils/constants.dart";

class Search extends StatefulWidget {
  List<dynamic> searchHistory = [];
  Search({super.key, required this.searchHistory});
  @override
  State<Search> createState() => _SearchState();
}

class SelectedBorder extends RoundedRectangleBorder
    implements MaterialStateOutlinedBorder {
  const SelectedBorder();

  @override
  OutlinedBorder? resolve(Set<MaterialState> states) {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)));
  }
}

class _SearchState extends State<Search> {
  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        searchController: controller,
        viewBackgroundColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        viewSurfaceTintColor: themeProvider.themeMode == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        viewHintText: 'Where To?',
        headerTextStyle: TextStyle(
          color: themeProvider.themeMode == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
        headerHintStyle: TextStyle(
          color: themeProvider.themeMode == ThemeMode.dark
              ? Colors.white
              : Colors.black,
        ),
        viewLeading: IconButton(
            onPressed: () {
              controller.clear();
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            icon: Icon(
              Icons.arrow_back_rounded,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            )),
        viewTrailing: [
          IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: Icon(
                Icons.close,
                color: themeProvider.themeMode == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
              ))
        ],
        builder: (BuildContext context, SearchController controller) {
          return Column(
            children: [
              SearchBar(
                shape: SelectedBorder(),
                controller: controller,
                focusNode: FocusNode(),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                  FocusScope.of(context).unfocus();
                },
                autoFocus: false,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    controller.openView();
                  } else {
                    controller.closeView(null);
                  }
                  FocusScope.of(context).unfocus();
                },
                leading: Icon(Icons.search,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black),
                hintText: 'Where To?',
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade900
                      : Colors.grey.shade300,
                ),
                surfaceTintColor: MaterialStateColor.resolveWith(
                  (states) => themeProvider.themeMode == ThemeMode.dark
                      ? Colors.grey.shade900
                      : Colors.grey.shade300,
                ),
                // shadowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                elevation: MaterialStateProperty.resolveWith((states) => 1),
                hintStyle: MaterialStateProperty.resolveWith(
                  (states) => TextStyle(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                    fontFamily: 'ProductSans',
                  ),
                ),
                textStyle:
                    MaterialStateProperty.resolveWith((states) => TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        )),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //   child: Divider(
              //     color: themeProvider.themeMode == ThemeMode.dark
              //         ? Colors.white
              //         : Colors.black,
              //     thickness: 1,
              //     height: 0,
              //   ),
              // ),
            ],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          final List<String> items = [
            'Manali',
            'Delhi',
            'Goa',
            'Chennai',
            'Hyderabad',
            'Bengaluru'
          ];
          final List<String> filteredItems = items
              .where((item) =>
                  item.toLowerCase().contains(controller.text.toLowerCase()))
              .toList();

          return filteredItems.map((item) {
            return Container(
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.black
                  : Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ListTile(
                  leading: Icon(Iconsax.location),
                  title: Text(
                    item,
                    style: TextStyle(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                  onTap: () async {
                    controller.clear();
                    controller.closeView(null);
                    if (widget.searchHistory.contains(item)) {
                      widget.searchHistory.remove(item);
                    }
                    widget.searchHistory.insert(0, item);
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .update({'searchHistory': widget.searchHistory});
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestDesc(place: item),
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}
