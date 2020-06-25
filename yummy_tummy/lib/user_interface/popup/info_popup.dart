import 'package:flutter/material.dart';

class InfoPopup extends StatelessWidget {

  final String _title;
  final String _text;
  final IconData _icon;

  InfoPopup([this._title = "Info", this._text = "", this._icon = Icons.info_outline]);

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
                        _icon,
                        size: 35.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          _title,
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
                      _text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                      ),
                    ),
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