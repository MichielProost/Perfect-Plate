import 'package:flutter/cupertino.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:yummytummy/database/authentication/google.dart';
import 'package:yummytummy/user_interface/constants.dart';

class GoogleSigninButtonWrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GoogleSignInButton(
      darkMode: false,
      onPressed: () => Constants.appUser.isLoggedIn() ? GoogleAuthHandler().handleSignOut() : GoogleAuthHandler().handleSignIn(),
      text: Constants.appUser.isLoggedIn() ? "Log out" : "Log in with Google",
    );
  }

}