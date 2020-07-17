import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/flutter_firebase_ui.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/model/app_user.dart';

class GoogleAuthHandler{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  UserServiceFirestore userService = new UserServiceFirestore();

  /// Sign in with Google.
  Future<AppUser> handleSignIn() async {

    GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );
    
    AuthResult result = (await _auth.signInWithCredential(credential));

    FirebaseUser googleUser = result.user;

    // Temporary.
    Map<String, dynamic> userData = {};

    return new AppUser(googleUser.uid, userData);
  }
}