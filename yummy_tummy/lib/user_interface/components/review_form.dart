import 'package:flutter/material.dart';
import 'package:yummytummy/user_interface/components/selectable_stars.dart';

import '../constants.dart';

class ReviewForm extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return _Form();
  }
  
}

class _Form extends State<ReviewForm> {
  
  String _reviewText = "";

  void _handleReview() {

  }

  @override
  Widget build(BuildContext context) {
    SelectableStars stars = SelectableStars(24.0);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          //TODO add language
          Text(
            "Rate this recipe!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0
            ),
          ),
          stars,
          TextField(
            minLines: 1,
            maxLines: 4,
            onChanged: (value) => {
              _reviewText = value,
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //TODO add language system
              Text(
                "Send review"
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: Constants.main,
                ), 
                onPressed: () => {
                  _handleReview(),
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}