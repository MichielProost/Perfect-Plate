import 'package:flutter/material.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';

import '../constants.dart';

class ReviewCard extends StatefulWidget {
  
  final Review _review;
  ReviewCard(this._review);
  
  @override
  State<StatefulWidget> createState() {
    return _Card();
  }
}

class _Card extends State<ReviewCard> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RatingRow.withSize(
                      widget._review.rating.toDouble(),
                      size: 22.0,
                    ),
                    // TODO replace by actual user info 
                    Text( 
                      widget._review.userMap['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                      ),
                    ),
                  ],
                ),
              ),
              Text( widget._review.description ),
            ],
          ),
        ),
        color: Constants.gray,
      ),
    );
  }
}