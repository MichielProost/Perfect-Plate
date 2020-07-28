import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/components/buttons/google_signin_button_wrapper.dart';
import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/user_interface/popup/search_by_user.dart';

class SideMenu extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<SideMenu> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Constants.main,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              
              Center(
                child: Column(
                  children: <Widget>[
                    Image.asset( 
                      "images/icon.png" ,
                      height: 75.0,
                    ),
                    Text(
                      "Yummy Tummy",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                      child: Container(
                        height: 1.0,
                        color: Constants.bg_gray,
                      ),
                    ),
                  ],
                ),
              ),

              // Log in button for logged out users
              if (!Constants.appUser.isLoggedIn())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoogleSigninButtonWrapper(
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),

              

              // Clickable elements
              ListTile(
                title: Text(
                  "Look up recipes by author",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                leading: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(context: context, child: SearchByName());
                },
              ),

              // Maximise space and logout button for logged in users
              Spacer(),
              if ( Constants.appUser.isLoggedIn())
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GoogleSigninButtonWrapper(
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}