import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/components/action_button.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

class ActionPopup extends StatelessWidget {
  
  final String title;
  final String text;
  final IconData icon;

  final Function() onAccept;
  final Function() onDecline;

  ActionPopup({this.title = "Info", this.text = "", this.icon = Icons.info_outline, this.onAccept, this.onDecline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 70.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: 35.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 1.0,
                          height: 1.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 35.0,
                        ), onPressed: () { Navigator.pop(context, null); },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      ),
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ActionButton(
                            Localization.instance.language.getMessage( 'accept' ),
                            onClick: () {
                              if (onAccept != null)
                                onAccept();

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),

                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ActionButton(
                            Localization.instance.language.getMessage( 'cancel' ),
                            onClick: () {
                              if (onDecline != null)
                                onDecline();

                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 1.0,
              width: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}