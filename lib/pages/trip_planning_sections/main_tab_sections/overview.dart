// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:voyager/components/trip_planning_section/friends_icons.dart';
import 'package:voyager/components/trip_planning_section/profile_tile.dart';

class OverviewTrips extends StatelessWidget {
  const OverviewTrips({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            children: [
              Text(
                'Your Tripmates',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: Row(
                  children: [
                    Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
                child: SizedBox(
                  height: 85,
                  width: screenWidth - 50,
                  child: FriendsIcons(),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Row(
            children: [
              Text(
                'Reservations and Attachments',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 80,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                children: [
                  SizedBox(
                    width: screenWidth / 4-15,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.flight_takeoff,
                          size: 50,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text('Flights'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,18),
                    child: VerticalDivider(
                      thickness: 0.25,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 4-15,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.train,
                          size: 50,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text('Trains',),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,18),
                    child: VerticalDivider(
                      thickness: 0.25,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 4-15,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Iconsax.bus5,
                          size: 50,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text('Buses',),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,18),
                    child: VerticalDivider(
                      thickness: 0.25,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 4-15,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.attachment_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        Spacer(),
                        Text('Attachment',),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _showBottomSheet(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Column(
        //crossAxisAlignment:CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
          ),
          SizedBox(
            height: screenHeight / 2 - 10,
            child: ListView.builder(
              itemCount: 100,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (bc, index) {
                return ProfileTile();
              },
            ),
          ),
        ],
      );
    },
  );
}
