// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:voyager/pages/destination_description.dart";
import "package:voyager/utils/constants.dart";

class destExp extends StatelessWidget {
  destExp({
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DestDesc()));
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
                      'Paris',
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
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: screenWidth / 2),
                      child: Text(
                        'Paris is an amazing place to visit this Summer. Paris is known for it romantic view.',
                        style: TextStyle(
                          color: themeProvider.themeMode == ThemeMode.dark
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
    );
  }
}
