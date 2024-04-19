// ignore_for_file: unused_import, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:voyager/components/explore_section/places.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_one_way.dart';
import 'package:voyager/pages/trip_planning_sections/main_tab_sections/form_sections/form_for_trains.dart';
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
  List<TicketData>? flightTicket;
  TrainData? trainTicket;
  int index;
  trips(
      {super.key,
      required this.screenWidth,
      required this.trip,
      required this.isNewTripPage,
      required this.isBookmarked,
      required this.index,
      this.flightTicket,
      this.trainTicket});
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

  void updateFlightTicketsInFirestore(List<TicketData>? flightTickets) async {
    if (flightTickets != null && flightTickets.isNotEmpty) {
      List<Map<String, dynamic>> flightData =
          flightTickets.map((item) => item.toJson()).toList();

      DocumentReference docRef = FirebaseFirestore.instance
          .collection("trips")
          .doc(widget.trip.tripId);

      await docRef.update({
        'attachments.flightTickets': FieldValue.arrayUnion(flightData),
      });
    } else {
      print('Flight tickets list is null or empty.');
    }
  }

  void sucessSnackBar() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Successfully Added',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'ProductSans',
              ),
            ),
          ),
        ),
      );
    }
  }

  void errorSnackBar() {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(
            child: Text(
              'Error Occured Please Try Again Later',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'ProductSans',
              ),
            ),
          ),
        ),
      );
    }
  }

  void updatetrainTicketsInFirestore(TrainData trainTicket) async {
    Map<String, dynamic> trainTicketMap = trainTicket.toMap();
    DocumentSnapshot tripDoc = await FirebaseFirestore.instance
        .collection("trips")
        .doc(widget.trip.tripId)
        .get();
    Map<String, dynamic>? tripData = tripDoc.data() as Map<String, dynamic>?;
    List<Map<String, dynamic>> existingTrainTickets =
        List<Map<String, dynamic>>.from(
            tripData?['attachments']['trainTickets'] ?? []);
    existingTrainTickets.add(trainTicketMap);
    await FirebaseFirestore.instance
        .collection("trips")
        .doc(widget.trip.tripId)
        .set(
      {
        'attachments': {
          'trainTickets': existingTrainTickets,
        },
      },
      SetOptions(merge: true),
    );
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
        onTap: () async {
          if (widget.index == 0) {
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
          } else if (widget.index == 1) {
            try {
              updateFlightTicketsInFirestore(widget.flightTicket);
              Navigator.pop(context);
              sucessSnackBar();
            } catch (error) {
              Navigator.pop(context);
              errorSnackBar();
            }
          } else if (widget.index == 2) {
            try {
              updatetrainTicketsInFirestore(widget.trainTicket!);
              Navigator.pop(context);
              sucessSnackBar();
            } catch (error) {
              Navigator.pop(context);
              errorSnackBar();
            }
          }
        },
        child: SizedBox(
          height: widget.screenWidth / 3 + 20,
          width: widget.screenWidth - 10,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: placeImgURL[widget.trip.location] as String,
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
