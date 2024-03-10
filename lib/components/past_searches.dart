// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:flutter/material.dart";

class PastSearches extends StatelessWidget {
  const PastSearches({
    super.key,
    required this.textData,
  });
  final textData;
  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.grey[800],
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.grey[800],
        onTap: () {
          //searchState.performSearch("Search Term");
          debugPrint(textData);
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            textData,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
