// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:voyager/models/trip_model.dart';
import 'package:voyager/pages/trip_planning_sections/trip_provider.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth firebaseAuth = FirebaseAuth.instance;

void fetchUserData(BuildContext context) async {
  final tripsProvider = Provider.of<TripsProvider>(context, listen: false);
  try {
    var uid = firebaseAuth.currentUser!.uid;
    var docSnapshot = await db.collection("users").doc(uid).get();
    if (docSnapshot.exists) {
      List<dynamic> dataArray = docSnapshot.data()!['trips'];
      List<Trip> trips = [];
      for (var tripData in dataArray) {
        String tripId = tripData['tripId'];
        bool isBookmarked = tripData['isBookmarked'];
        var tripSnapshot = await db.collection("trips").doc(tripId).get();
        if (tripSnapshot.exists) {
          Trip trip = Trip.fromFirestore(tripSnapshot, isBookmarked);
          trips.add(
            trip,
          );
        } else {
          print("Trip with ID $tripId does not exist!");
        }
      }
      tripsProvider.tripList = trips;

      db.collection("users").doc(uid).snapshots().listen((snapshot) async {
        List<dynamic> updatedDataArray = snapshot.data()!['trips'];
        List<Trip> updatedTrips = [];
        for (var tripData in updatedDataArray) {
          String tripId = tripData['tripId'];
          bool isBookmarked = tripData['isBookmarked'];
          var tripSnapshot = await db.collection("trips").doc(tripId).get();
          if (tripSnapshot.exists) {
            Trip trip = Trip.fromFirestore(tripSnapshot, isBookmarked);
            updatedTrips.add(trip);
          } else {
            print("Trip with ID $tripId does not exist!");
          }
        }
        tripsProvider.tripList = updatedTrips;
      });
    } else {
      print("Document does not exist!");
    }
  } catch (e) {
    print("Error fetching user data: $e");
  }
}
