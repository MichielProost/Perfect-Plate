import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';

class SideMenu extends StatelessWidget{
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: <Widget>[
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