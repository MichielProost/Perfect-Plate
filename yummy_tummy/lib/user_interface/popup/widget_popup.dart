import 'package:flutter/material.dart';

class WidgetPopup extends StatelessWidget{
  
  final Widget child;

  WidgetPopup(this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 70.0),
      child: Column(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                
                // Button row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CloseButton(
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),

                // Chosen child widget
                child,

              ],
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