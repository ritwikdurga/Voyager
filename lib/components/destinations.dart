// ignore_for_file: prefer_const_constructors, camel_case_types

import "package:flutter/material.dart";

class Destinations extends StatelessWidget {
  const Destinations({
    super.key,
    required this.screenWidth,
  });
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.grey[800],
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.grey[800],
        onTap: () {
          //redirect to trip page
        },
        child: SizedBox(
          width: screenWidth/3-10,
          height: screenWidth*2/3,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:5,vertical:10),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: screenWidth/2,
                        maxWidth: screenWidth/3-20,),
                    child: Image.asset(
                      'assets/images/a.png',
                    )),
              ),
              Text(
                'Paris',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}