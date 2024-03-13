// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/utils/constants.dart";

import "../utils/colors.dart";

class trips extends StatelessWidget {
  trips({
    super.key,
    required this.screenWidth,
  });

  final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: shape,
      color: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      surfaceTintColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      elevation: 0,
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: () {
          // redirect to planning page.
        },
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
                  child: Image.asset(
                    'assets/images/a.png',
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
                      'Paris Trip',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: 0.25),
                    Text(
                      '31 Mar - 4 Apr',
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth / 2),
                      child: Text(
                        'Planning with abc,xyz,def,ghi,jkl,mno,pqr,stu,vwx,yz,123,456,789,0',
                        style: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
