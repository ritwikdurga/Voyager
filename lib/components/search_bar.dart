// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:group9_auth/utils/constants.dart";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final SearchController controller = SearchController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        searchController: controller,
        viewBackgroundColor: Colors.white,
        viewSurfaceTintColor: Colors.white,
        isFullScreen: false,
        viewHintText: 'Where To?',
        viewLeading: IconButton(
            onPressed: () {
              controller.clear();
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
              
            },
            icon: Icon(Icons.arrow_back_rounded)),
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
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
            leading: const Icon(Icons.search),
            hintText: 'Where To?',
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white),
            hintStyle: MaterialStateProperty.resolveWith(
              (states) => TextStyle(
                color: Colors.black,
                fontFamily: 'ProductSans',
              ),
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<Widget>.generate(15, (int index) {
            final String item = 'item $index';
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: ListTile(
                  title: Text(
                    item,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'ProductSans',
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                      FocusScope.of(context).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    });
                  },
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
