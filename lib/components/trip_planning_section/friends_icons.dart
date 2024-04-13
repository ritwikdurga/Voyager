// ignore_for_file: avoid_print, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voyager/services/fetch_userdata.dart';
import 'package:voyager/utils/constants.dart';

class FriendsIcons extends StatelessWidget {
  String tripId;
  FriendsIcons({super.key, required this.tripId});
  String photoURL =
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80';

  // Text controller for capturing the email
  final TextEditingController _emailController = TextEditingController();

  void sendInvitation(String email) async {
    try {
      final docRef = FirebaseFirestore.instance.collection("email").doc(email);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final uid = docSnapshot.data()!['uid'];
        if (uid == firebaseAuth.currentUser!.uid) {
          print("This email belongs to this account.");
        } else {
          await FirebaseFirestore.instance.collection("users").doc(uid).update({
            'pendingInvitations': FieldValue.arrayUnion([tripId])
          });
        }
      } else {
        print('Error: Document with email $email does not exist.');
      }
    } catch (e) {
      print('Error sending invitation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 15,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, index) {
        if (index == 0) {
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('Send Invitation'),
                          content: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                controller:
                                    _emailController, // Assign controller
                                decoration: const InputDecoration(
                                  fillColor: Colors.transparent,
                                  hintText: 'Enter email of your friend',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text('Send'),
                              onPressed: () {
                                // Access email entered by the user
                                String email = _emailController.text;
                                sendInvitation(email);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(
                      color: themeProvider.themeMode == ThemeMode.dark
                          ? Colors.white
                          : Colors.black,
                      width: 0.5,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: kGreenColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          );
        }
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                _showNameContainer(context);
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(photoURL),
              ),
            ),
            if (index != 14)
              const SizedBox(
                width: 8,
              ),
          ],
        );
      },
    );
  }
}

void _showNameContainer(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.white
          : Colors.black,
      content: Center(
        child: Text(
          'Nithin',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.w500,
            color: themeProvider.themeMode == ThemeMode.dark
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
