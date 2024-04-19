// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class Invitation {
  String tripId;
  String title;
  String location;
  DateTime startDate;
  DateTime endDate;
  String createdBy;

  Invitation({
    required this.tripId,
    required this.title,
    required this.location,
    required this.createdBy,
    required this.startDate,
    required this.endDate,
  });

  factory Invitation.fromJson(Map<String, dynamic> json, String tripId) {
    return Invitation(
      tripId: tripId,
      title: json['title'],
      location: json['location'],
      createdBy: json['creator'],
      startDate: json['startDate'].toDate(),
      endDate: json['endDate'].toDate(),
    );
  }
}

class InvitationListPage extends StatefulWidget {
  const InvitationListPage({super.key});

  @override
  State<InvitationListPage> createState() => _InvitationListPageState();
}

class _InvitationListPageState extends State<InvitationListPage> {
  List<Invitation> invitationDataList = [];

  @override
  Widget build(BuildContext context) {
    // take the screen height
    double screenHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Invitation List',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              fontFamily: 'ProductSans'),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No invitations available.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey[300]
                            : Colors.grey[700],
                        fontFamily: 'ProductSans'),
                  ),
                ),
              ],
            );
          }

          var data = snapshot.data!;
          List? invitations;
          try {
            invitations = data.get('pendingInvitations') as List<dynamic>?;
          } catch (error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No pending invitations.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey[300]
                            : Colors.grey[700],
                        fontFamily: 'ProductSans'),
                  ),
                ),
              ],
            );
          }
          if (invitations == null || invitations.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No pending invitations.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: themeProvider.themeMode == ThemeMode.dark
                            ? Colors.grey[300]
                            : Colors.grey[700],
                        fontFamily: 'ProductSans'),
                  ),
                ),
              ],
            );
          }

          return FutureBuilder<List<Invitation>>(
            future: _fetchInvitations(invitations),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final invitationDataList = snapshot.data!;
              if (invitationDataList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      'No pending invitations.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: themeProvider.themeMode == ThemeMode.dark
                              ? Colors.grey[300]
                              : Colors.grey[700],
                          fontFamily: 'ProductSans'),
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/sleep.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ],
                );
              }

              return ListView.builder(
                itemCount: invitationDataList.length,
                itemBuilder: (context, index) {
                  final invitation = invitationDataList[index];
                  return ListTile(
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(invitation.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.deepOrange,
                                  fontFamily: 'ProductSans')),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${DateFormat('dd MMM').format(invitation.startDate)} - ${DateFormat('dd MMM').format(invitation.endDate)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: themeProvider.themeMode == ThemeMode.dark
                                  ? Colors.grey[300]
                                  : Colors.grey[700],
                              fontFamily: 'ProductSans'),
                        ),
                        Row(
                          children: [
                            Text('Trip to ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'ProductSans')),
                            Text('${invitation.location}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontFamily: 'ProductSans')),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Created By ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                    fontFamily: 'ProductSans')),
                            Text('${invitation.createdBy}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                    fontFamily: 'ProductSans')),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            _acceptInvitation(invitation);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _declineInvitation(invitation);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Invitation>> _fetchInvitations(
      List<dynamic>? invitationIds) async {
    final List<Invitation> invitationDataList = [];
    if (invitationIds != null) {
      for (final invitationId in invitationIds) {
        try {
          final docSnapshot = await FirebaseFirestore.instance
              .collection("trips")
              .doc(invitationId)
              .get();
          if (docSnapshot.exists) {
            final invitationData =
                Invitation.fromJson(docSnapshot.data()!, invitationId);
            final creatorDoc = await FirebaseFirestore.instance
                .collection("users")
                .doc(invitationData.createdBy)
                .get();
            invitationData.createdBy = creatorDoc.get('name');
            invitationDataList.add(invitationData);
          } else {
            print("Document does not exist for trip ID: $invitationId");
          }
        } catch (error) {
          print(
              "Error fetching document for trip ID: $invitationId, Error: $error");
        }
      }
    }
    return invitationDataList;
  }

  Future<void> _acceptInvitation(Invitation invitation) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'trips': FieldValue.arrayUnion([
        {
          'tripId': invitation.tripId,
          'isBookmarked': false,
        }
      ]),
    });
    await FirebaseFirestore.instance
        .collection('trips')
        .doc(invitation.tripId)
        .update({
      'collaborators':
          FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
    });
    setState(() {
      invitationDataList.remove(invitation);
    });
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'pendingInvitations': FieldValue.arrayRemove([invitation.tripId])
      });
    } catch (error) {
      print("Error removing declined invitation: $error");
    }
  }

  Future<void> _declineInvitation(Invitation invitation) async {
    setState(() {
      invitationDataList.remove(invitation);
    });
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'pendingInvitations': FieldValue.arrayRemove([invitation.tripId])
      });
    } catch (error) {
      print("Error removing declined invitation: $error");
    }
  }
}
