// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";
import "package:provider/provider.dart";
import "package:voyager/pages/explore_sections/destination_description.dart";
import "package:voyager/utils/constants.dart";

import "../../utils/colors.dart";

class Search extends StatefulWidget {
  const Search({super.key});

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
              controller?.clear();
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
            'Paris',
            'London',
            'New York',
            'Tokyo',
            'Rome',
            'Berlin'
          ]; // Example list of items
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
                  onTap: () {
                    controller.clear();
                    controller.closeView(null);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => DestDesc()));
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
