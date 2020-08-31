import 'dart:math';

// The importance of the notion quantity.
// Q = 1.44 * M with M = "moderate" number of reviews.
// Our choice: M = 50.
const Q = 72;

/// Calculate new average rating based on old average rating [oldRating].
/// [newValue] : The score of the new [Review].
/// [amount] : The amount of total reviews for a particular [Recipe]
double calculateAverageRating(double oldRating, int newValue, int amount){

  return
    ( ( oldRating * amount ) + newValue ) / ( amount + 1 );

}

/// Calculate new weighted rating in [0-10].
double calculateWeightedRating(double avgRating, int amount){

  return
      avgRating + ( 5 * ( 1 - pow( e, ( -( amount + 1 ) / Q ) ) ) );

}