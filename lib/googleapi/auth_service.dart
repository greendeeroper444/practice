import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<void> signInWithGoogle() async {
  try {
    // Sign out silently to ensure the account chooser dialog is shown
    await googleSignIn.signOut();

    // Choose a Google account
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    // Check if the user canceled the account selection
    if (googleSignInAccount == null) {
      print("User canceled the Google Sign In");
      return;
    }

    // Retrieve authentication details
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    // Create credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // Sign in with Firebase
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;

    // Do something with the signed-in user
    print("User signed in: ${user?.displayName}");

  } catch (e) {
    print(e.toString());
  }
}
