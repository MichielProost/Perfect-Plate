import 'package:flutter/cupertino.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:yummytummy/database/authentication/google.dart';
import 'package:yummytummy/user_interface/constants.dart';

class GoogleSigninButtonWrapper extends StatefulWidget {

  final VoidCallback onPressed;

  GoogleSigninButtonWrapper({this.onPressed});

  @override
  State<StatefulWidget> createState() {
    return _SigninButton();
  }

}

class _SigninButton extends State<GoogleSigninButtonWrapper> {
  
  bool isLoggedIn = Constants.appUser.isLoggedIn();

  @override
  Widget build(BuildContext context) {
    return GoogleSignInButton(
      darkMode: false,
      onPressed: () {
        handleAuthChange();
        if (widget.onPressed != null)
          widget.onPressed();
      },
      text: Constants.appUser.isLoggedIn() ? "Sign out of Google" : "Log in with Google",
    );
  }

  void handleAuthChange() async
  {
    if( Constants.appUser.isLoggedIn() ) {
      GoogleAuthHandler().handleSignOut();
      setState(() {
        isLoggedIn = true;
      });
    } else {
      GoogleAuthHandler().handleSignIn();
      setState(() {
        isLoggedIn = false;
      });
    }
  }

}