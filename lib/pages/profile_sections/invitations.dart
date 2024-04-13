// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitation List'),
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
            return const Center(
              child: Text('No invitations available.'),
            );
          }

          var data = snapshot.data!;
          List? invitations;
          try {
            invitations = data.get('pendingInvitations') as List<dynamic>?;
          } catch (error) {
            return const Center(
              child: Text('No pending invitations.'),
            );
          }
          if (invitations == null || invitations.isEmpty) {
            return const Center(
              child: Text('No pending invitations.'),
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
                return const Center(
                  child: Text('No pending invitations.'),
                );
              }

              return ListView.builder(
                itemCount: invitationDataList.length,
                itemBuilder: (context, index) {
                  final invitation = invitationDataList[index];
                  return ListTile(
                    title: Text(invitation.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${invitation.location}'),
                        Text(
                          '${DateFormat('dd MMM').format(invitation.startDate)}-${DateFormat('dd MMM').format(invitation.endDate)}',
                        ),
                        Text('Creator: ${invitation.createdBy}')
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _acceptInvitation(invitation);
                          },
                          child: const Text('Accept'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () async {
                            await _declineInvitation(invitation);
                          },
                          child: const Text('Decline'),
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
