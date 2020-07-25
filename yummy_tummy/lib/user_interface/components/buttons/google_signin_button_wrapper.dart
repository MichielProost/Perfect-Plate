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
      },
      text: Constants.appUser.isLoggedIn() ? "Sign out of Google" : "Log in with Google",
    );
  }

  Future<void> handleAuthChange() async
  {
    if( Constants.appUser.isLoggedIn() ) {
      await GoogleAuthHandler().handleSignOut();
      setState(() {
        isLoggedIn = true;
      });
    } else {
      await GoogleAuthHandler().handleSignIn();
      setState(() {
        isLoggedIn = false;
      });
    }

    if (widget.onPressed != null)
      widget.onPressed();
  }

}