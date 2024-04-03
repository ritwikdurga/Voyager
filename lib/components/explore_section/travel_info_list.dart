// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:voyager/components/explore_section/travel_info_icon.dart';

class TravelInfoList extends StatelessWidget {
  TravelInfoList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TravelInfoIcon(icon: Icon(Icons.account_balance, size: 30), text: 'Understand'),
        SizedBox(
            width: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 34.0),
              child: VerticalDivider(
                thickness: 0.25,
              ),
            )),
        TravelInfoIcon(
            icon: Icon(Icons.flight, size: 30), text: 'Travel'),
        SizedBox(
            width: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 34.0),
              child: VerticalDivider(
                thickness: 0.25,
              ),
            )),
        TravelInfoIcon(
            icon: Icon(Icons.train_outlined, size: 30), text: 'Get around'),
        SizedBox(
            width: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 34.0),
              child: VerticalDivider(
                thickness: 0.25,
              ),
            )),
        TravelInfoIcon(
            icon: Icon(Icons.confirmation_num, size: 30), text: 'Events'),
        SizedBox(
            width: 5,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 34.0),
              child: VerticalDivider(
                thickness: 0.25,
              ),
            )),
        TravelInfoIcon(
            icon: Icon(Icons.safety_check, size: 30), text: 'Safety'),
      ],
    );
  }
}
