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
    var docSnapshot = db.collection("users").doc(uid).snapshots();
    docSnapshot.listen((doc) async {
      if (doc.exists) {
        List<dynamic> dataArray = doc.data()!['trips'];
        List<Trip> trips = [];
        for (var tripId in dataArray) {
          var tripSnapshot = await db.collection("trips").doc(tripId).get();
          if (tripSnapshot.exists) {
            Trip trip = Trip.fromFirestore(tripSnapshot);
            trips.insert(0, trip);
          } else {
            print("Trip with ID $tripId does not exist!");
          }
        }
        tripsProvider.tripList = trips;
      } else {
        print("Document does not exist!");
      }
    });
  } catch (e) {
    print("Error fetching user data: $e");
  }
}
