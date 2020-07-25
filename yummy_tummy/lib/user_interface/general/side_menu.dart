import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';
import 'package:yummytummy/user_interface/constants.dart';

class SideMenu extends StatelessWidget{
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            // Log in button for logged out users
            if ( ! Constants.appUser.isLoggedIn())
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GoogleSigninButtonWrapper(),
              ),

            // Add

            // Maximise space and logout button for logged in users
            Spacer(),
            if ( Constants.appUser.isLoggedIn())
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GoogleSigninButtonWrapper(),
              ),
          ],
        ),
      ),
    );
  }
}