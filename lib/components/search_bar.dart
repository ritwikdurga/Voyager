// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
          viewBackgroundColor: Colors.grey,
          isFullScreen: false,
          viewHintText: 'Where To?',
          builder: (BuildContext context, SearchController controller) {
            return SearchBar(
              controller: controller,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              onTap: () {
                controller.openView();
                FocusScope.of(context).unfocus();
              },
              autoFocus: false,
              onChanged: (_) {
                controller.openView();
              },
              leading: const Icon(Icons.search),
              hintText: 'Where To?',
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.grey),
              hintStyle: MaterialStateProperty.resolveWith(
                  (states) => TextStyle(color: Colors.black45)),
            );
          },
          suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
    );
  }
}
