// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:voyager/services/fetch_userdata.dart';
import 'package:voyager/utils/constants.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart'; // Import Bounceable package
import 'package:firebase_storage/firebase_storage.dart';
import '../../utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:voyager/models/trip_model.dart';
import 'package:intl/intl.dart';
import 'package:voyager/pages/trip_planning_sections/continue_planning.dart';

class trips extends StatefulWidget {
  late Trip trip;
  bool isNewTripPage = false;
  bool isBookmarked;
  trips(
      {super.key,
      required this.screenWidth,
      required this.trip,
      required this.isNewTripPage,
      required this.isBookmarked});
  final double screenWidth;
  @override
  State<trips> createState() => _tripsState();
}

class _tripsState extends State<trips> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2300));
  }

  void updateBookmark() async {
    try {
      var uid = firebaseAuth.currentUser!.uid;
      var userDocRef = db.collection("users").doc(uid);
      var docSnapshot = await userDocRef.get();
      if (docSnapshot.exists) {
        List<dynamic> tripsData = docSnapshot.data()!['trips'];

        for (int i = 0; i < tripsData.length; i++) {
          Map<String, dynamic> tripData = tripsData[i];
          if (tripData['tripId'] == widget.trip.tripId) {
            tripsData[i]['isBookmarked'] = widget.isBookmarked;
            break;
          }
        }
        await userDocRef.update({'trips': tripsData});
      } else {
        print("User document does not exist!");
      }
    } catch (e) {
      print("Error updating bookmark: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
  );

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final dateFormat = DateFormat('d MMM');
    final startDateFormatted = dateFormat.format(widget.trip.startDate);
    final endDateFormatted = dateFormat.format(widget.trip.endDate);
    if (widget.isBookmarked) _controller.forward();
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
      child: Bounceable(
        // Wrap InkWell with Bounceable
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContinuePlanning(
                tripId: widget.trip.tripId,
                isNewTripPage: widget.isNewTripPage,
                isBookmarked: widget.isBookmarked,
                // updateList: widget.updateListCP,
              ),
            ),
          );
        },
        child: SizedBox(
          height: widget.screenWidth / 3 + 20,
          width: widget.screenWidth - 10,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/a.png',
                fit: BoxFit.cover,
                height: widget.screenWidth / 3 + 20,
                width: widget.screenWidth - 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '$startDateFormatted - $endDateFormatted',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            if (widget.isBookmarked) {
                              _controller.reverse();
                              widget.isBookmarked = false;
                            } else {
                              widget.isBookmarked = true;
                              _controller.forward();
                            }
                            updateBookmark();
                          },
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Lottie.network(
                              'https://lottie.host/bee59ff8-eb4a-4245-9e8d-ad6521f98bf1/zFNurdNhaS.json',
                              controller: _controller,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      widget.trip.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
