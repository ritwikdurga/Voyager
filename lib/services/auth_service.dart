// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:voyager/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voyager/pages/profile_sections/user_provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  void createUserEntry(User user, String name) async {
    UserModel userDerived = UserModel(name, user.email, user.uid,
        user.metadata.creationTime!.toIso8601String(), user.photoURL);
    await db.collection('users').doc(user.uid).set(userDerived.toMap());
  }

  signInWithGoogle() async {
    // Sign in with Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Get Google authentication details
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in the user with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Retrieve user details
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      createUserEntry(currentUser, currentUser.displayName as String);
    }
    return currentUser;
  }

  Future registerWithEmail(String email, String password, String name) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      createUserEntry(currentUser, name);
    }
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await user.updateDisplayName(name);
        await user.updatePhotoURL(
            "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png");
      }
    });
    return currentUser;
  }

  Future signInWithEmail(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final currentUser = _auth.currentUser;
  }

  // apple signin
  signInWithApple() async {
    // Sign in with Apple
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create a new credential for the user
    final credential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in the user with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    // Retrieve user details
    final currentUser = _auth.currentUser;
    // Return the user details
    return currentUser;
  }
}
