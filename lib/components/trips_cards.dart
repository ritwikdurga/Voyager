import "package:flutter/material.dart";
import "package:group9_auth/utils/constants.dart";

class trips extends StatelessWidget {
  trips({
    Key? key,
    required this.screenWidth,
  }) : super(key: key);

  final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Card(

      clipBehavior: Clip.hardEdge,
      shape: shape,
      color: Colors.black,
      elevation: 10,
      shadowColor: kGreenColor,
      // Set shadowColor to transparent to avoid duplicate shadows

      child: InkWell(
        splashColor: Colors.black,
        onTap: () {
          // redirect to planning page.
        },
        child: SizedBox(
          height: screenWidth / 3,
          width: screenWidth - 10,
          child: Card(
            shape: shape,
            color: Colors.black,
            elevation: 9,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
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
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 0.25),
                      Text(
                        '31 Mar - 4 Apr',
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: screenWidth / 2),
                        child: Text(
                          'Planning with abc,xyz,def,ghi,jkl,mno,pqr,stu,vwx,yz,123,456,789,0',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
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
