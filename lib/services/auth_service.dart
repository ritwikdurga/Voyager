// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  // Google signin
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
    final currentUser = FirebaseAuth.instance.currentUser;
    final displayName = googleUser.displayName; // Retrieve the display name

    // Return the user details
    return currentUser;
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
    final currentUser = FirebaseAuth.instance.currentUser;
    // Return the user details
    return currentUser;
  }
}
