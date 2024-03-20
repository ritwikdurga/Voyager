import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider extends ChangeNotifier {
  late String _name;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserProvider() {
    _initializeName();
  }

  String get name => _name;

  void _initializeName() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      _name = currentUser.displayName ?? 'NaN';
    } else {
      _name = 'NaN';
    }
  }

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void clearUserData() {
    _name = 'NaN';
    notifyListeners();
  }
}
