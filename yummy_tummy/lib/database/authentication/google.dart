import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/model/app_user.dart';
import 'package:yummytummy/model/board/board_functions.dart';
import 'package:yummytummy/model/board/medal_board.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/home_screen.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

class GoogleAuthHandler{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  UserServiceFirestore userService = new UserServiceFirestore();

  /// Sign in with Google.
  /// Returns true if the user already exists
  /// Returns false if this is a new user
  Future<bool> handleSignIn({HomeScreenState screen}) async {

    bool userExists = false;

    // Stop homescreen touching
    if (screen != null)
      screen.setTouchable(false);

    GoogleSignInAccount googleAccount =
      await _googleSignIn.signIn().catchError((onError){
        print("User cancelled Sign in. Error: $onError");
      });

    if (googleAccount != null)
    {
      GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
      );

      AuthResult result = (await _auth.signInWithCredential(credential));

      FirebaseUser googleUser = result.user;

      Map<String, dynamic> userData;

      // Get user data from database.
      userExists = await userService.userExists(googleUser.uid);
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
            dietFieldPreference: DietField.any,
            recipeTypePreference: RecipeType.any,
            languagePreference: LanguagePick.english,
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

    // Re-enable homescreen touching
    if (screen != null)
      screen.setTouchable(true);

    return userExists;
  }

  /// Sign out from Google.
  Future<void> handleSignOut() async {

    await _auth.signOut().then((value){
      _googleSignIn.signOut();
    });

    Constants.appUser = AppUser.offline();

  }


}