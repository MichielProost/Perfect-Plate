import 'package:flutter/material.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/user.dart';
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
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RatingRow.withSize(
                      widget._review.rating.toDouble(),
                      size: 22.0,
                    ),
                    // TODO replace by actual user info
                    Text(
                      widget._review.user.rank.getString(),
                    ), 
                    Text( 
                      widget._review.user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 7.0),
                child: Text( widget._review.description ),
              ),
            ],
          ),
        ),
        color: Constants.gray,
      ),
    );
  }
}