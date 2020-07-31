import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/model/app_user.dart';
import 'package:yummytummy/model/board/board_functions.dart';
import 'package:yummytummy/model/board/medal_board.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/constants.dart';

class GoogleAuthHandler{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  UserServiceFirestore userService = new UserServiceFirestore();

  /// Sign in with Google.
  Future<void> handleSignIn() async {

    // TODO Michiel: handle log in cancel (PlatformException!!)
    GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );
    
    AuthResult result = (await _auth.signInWithCredential(credential));

    FirebaseUser googleUser = result.user;

    Map<String, dynamic> userData;

    // Get user data from database.
    bool userExists = await userService.userExists(googleUser.uid);
    if (userExists){
      // Get existing user.
      User user = await userService.getUserFromID(googleUser.uid);
      userData = user.toMap();
    } else {
      // Create a new user.
      User user = new User(
        id: googleUser.uid,
        name: googleUser.displayName,
        score: 0,
        rank: RankType.dishwasher,
        favourites: [],
        image: '',
        board: new MedalBoard(
            seriesMap: dataToSeriesMap(getDefaultDataMap()))
      );
      userData = user.toMap();
      // Create new user document.
      await userService.addUser(user, googleUser.uid);
    }

    Constants.appUser = new AppUser(googleUser.uid, userData);

    userService.scoreListener();

  }

  /// Sign out from Google.
  Future<void> handleSignOut() async {

    await _auth.signOut().then((value){
      _googleSignIn.signOut();
    });

    Constants.appUser = AppUser.offline();

  }


}