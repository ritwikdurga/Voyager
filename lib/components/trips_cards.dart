// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:flutter/material.dart";

class trips extends StatelessWidget {
  trips({
    super.key,
    required this.screenWidth,
  });
  final ShapeBorder shape=RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)));
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: shape,
      color: Colors.grey[800],
      child: InkWell(
        splashColor: Colors.grey[800],
        onTap: () {
          // redirect to planning page.
        },
        child: SizedBox(
          height: screenWidth / 3,
          width: screenWidth - 10,
          child: Card(
            color: Colors.grey[800],
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5, vertical: 8),
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: (screenWidth / 3) - 16,
                          maxWidth: screenWidth / 3),
                      child: Image.asset(
                        'assets/images/a.png',
                      )),
                  SizedBox(
                    width: screenWidth / 20,
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        'Paris Trip',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 0.25),
                      Text(
                        '31 Mar - 4 Apr',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: screenWidth / 2),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 2,
                          'Planning with abc,xyz,ajhsjdfsdfgdfgdfgdsgfdfsgdfdsfdfsfdfsfd',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
