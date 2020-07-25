import 'package:yummytummy/model/board/series/series.dart';
import 'package:yummytummy/model/board/medal.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/review.dart';

/// Checks a number to determine whether the current medal has been achieved.
abstract class CheckNumberSeries extends Series {

  List<int> goals = new List<int>();

  /// Constructor.
  CheckNumberSeries(this.goals, List<Medal> medals)
      : super(medals);

}

/// Checks the number of own recipes to determine whether the current medal has been achieved.
class CheckNumberOfOwnRecipes extends CheckNumberSeries {

  /// Constructor.
  CheckNumberOfOwnRecipes(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(goals, objects) {
    List<Recipe> ownRecipes = new List<Recipe>();
    // The input is a list of the user's own recipes.
    ownRecipes.addAll(objects);
    // If the amount of recipes is larger than the current goal...
    if (ownRecipes.length >= goals[super.getMedalsAchieved() - 1]){
      super.isAchieved();
    }
  }

}

/// Checks the number of own reviews to determine whether the current medal has been achieved.
class CheckNumberOfOwnReviews extends CheckNumberSeries {

  /// Constructor.
  CheckNumberOfOwnReviews(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(goals, objects) {
    List<Review> ownReviews = new List<Review>();
    // The input is a list of the user's own reviews.
    ownReviews.addAll(objects);
    // If the amount of recipes is larger than the current goal...
    if (ownReviews.length >= goals[super.getMedalsAchieved() - 1]){
      super.isAchieved();
    }
  }

}

/// Checks the number of received reviews to determine whether the current medal has been achieved.
class CheckNumberOfReceivedReviews extends CheckNumberSeries {

  /// Constructor.
  CheckNumberOfReceivedReviews(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(goals, objects) {
    List<Recipe> ownRecipes = new List<Recipe>();
    // The input is a list of the user's own recipes.
    ownRecipes.addAll(objects);

    // Count the amount of received reviews.
    int receivedReviews = 0;
    for(int i = 0; i < ownRecipes.length; i++) {
      receivedReviews += ownRecipes[i].numberOfReviews;
    }

    // If the amount of recipes is larger than the current goal...
    if (receivedReviews >= goals[super.getMedalsAchieved() - 1]){
      super.isAchieved();
    }
  }
}