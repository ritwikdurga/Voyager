// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:voyager/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  void createUserEntry(User user, String name, String photoURL) async {
    UserModel userDerived = UserModel(name, user.email, user.uid,
        user.metadata.creationTime!.toIso8601String(), photoURL);
    await db.collection('users').doc(user.uid).set(userDerived.toMap());
  }

  // Function to sign out from Google
  Future<void> signOutFromGoogle() async {
    await GoogleSignIn().signOut();
  }

// Function to sign in with Google
  signInWithGoogle() async {
    // Sign out the user first to ensure the account chooser dialog is shown
    await signOutFromGoogle();

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
    final currentUser = FirebaseAuth.instance.currentUser;

    // If the current user is not null, create a user entry
    if (currentUser != null) {
      createUserEntry(currentUser, currentUser.displayName as String,
          currentUser.photoURL as String);
    }

    return currentUser;
  }

  Future registerWithEmail(String email, String password, String name) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    const String photoURL =
        "https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png";
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      createUserEntry(currentUser, name, photoURL);
    }
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await user.updateDisplayName(name);
        await user.updatePhotoURL(photoURL);
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

    await FirebaseAuth.instance.signInWithCredential(credential);

    final currentUser = _auth.currentUser;
    return currentUser;
  }
}
