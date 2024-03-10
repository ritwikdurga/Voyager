// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: MaterialButton(onPressed: (){
          FirebaseAuth.instance.signOut();
        },
        color: Colors.deepPurple,
        child:Text('Sign Out'),
        ),
      ),
    );
  }
}