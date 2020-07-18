import 'package:flutter/material.dart';
import 'package:yummytummy/database/dummy/dummydatabase.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/user_interface/components/rating_row.dart';
import 'package:yummytummy/user_interface/components/review_card.dart';

class RecipeRatings extends StatelessWidget {
  
  final String _recipeID;
  final RatingRow _ratingRow;

  final ReviewService _reviewService = DummyDatabase( delayInMilliseconds: 100 );

  RecipeRatings(this._recipeID, this._ratingRow);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 60.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _ratingRow,
                  CloseButton(),
                ],
              ),
              FutureBuilder<List<Review>>(
                future: _reviewService.getReviewsFromRecipe( _recipeID ),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null || snapshot.data == null) {
                    return Container();
                  }

                  List<Review> reviews = snapshot.data;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ReviewCard( reviews[index] );
                    }
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}