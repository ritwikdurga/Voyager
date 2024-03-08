import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  // Google signin
  signInWithGoogle() async {
    // Sign in with Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Get Google authentication details
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

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


}
