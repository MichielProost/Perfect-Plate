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

  int amountOfOwnRecipes = 0;

  /// Constructor.
  CheckNumberOfOwnRecipes(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(List<dynamic> objects) {
    // The input is a list of the user's own recipes.
    List<Recipe> ownRecipes = objects;
    this.amountOfOwnRecipes = ownRecipes.length;
    // If the amount of recipes is larger than the current goal...
    if (ownRecipes.length >= this.goals[super.getMedalsAchieved()]){
      super.isAchieved();
    }
  }

  double getProgress(){
    int medalsAchieved = super.getMedalsAchieved();
    int previousGoal = 0;
    if (medalsAchieved > 0 ){
      previousGoal = this.goals[medalsAchieved - 1];
    }
    if(medalsAchieved == super.getMedalAmount()){
      return 1.0;
    }
    int goal = this.goals[medalsAchieved];
    return
      (this.amountOfOwnRecipes - previousGoal) / (goal - previousGoal);
  }

}

/// Checks the number of own reviews to determine whether the current medal has been achieved.
class CheckNumberOfOwnReviews extends CheckNumberSeries {

  int amountOfOwnReviews = 0;

  /// Constructor.
  CheckNumberOfOwnReviews(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(List<dynamic> objects) {
    // The input is a list of the user's own reviews.
    List<Review> ownReviews = objects;
    this.amountOfOwnReviews = ownReviews.length;
    // If the amount of recipes is larger than the current goal...
    if (ownReviews.length >= this.goals[super.getMedalsAchieved()]){
      super.isAchieved();
    }
  }

  double getProgress(){
    int medalsAchieved = super.getMedalsAchieved();
    int previousGoal = 0;
    if (medalsAchieved > 0 ){
      previousGoal = this.goals[medalsAchieved - 1];
    }
    if(medalsAchieved == super.getMedalAmount()){
      return 1.0;
    }
    int goal = this.goals[medalsAchieved];
    return
      (this.amountOfOwnReviews - previousGoal) / (goal - previousGoal);
  }

}

/// Checks the number of received reviews to determine whether the current medal has been achieved.
class CheckNumberOfReceivedReviews extends CheckNumberSeries {

  int amountOfReceivedReviews = 0;

  /// Constructor.
  CheckNumberOfReceivedReviews(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(List<dynamic> objects) {
    // The input is a list of the user's own recipes.
    List<Recipe> ownRecipes = objects;

    // Count the amount of received reviews.
    int receivedReviews = 0;
    for(int i = 0; i < ownRecipes.length; i++) {
      receivedReviews += ownRecipes[i].numberOfReviews;
    }

    this.amountOfReceivedReviews = receivedReviews;

    // If the amount of recipes is larger than the current goal...
    if (receivedReviews >= this.goals[super.getMedalsAchieved()]){
      super.isAchieved();
    }
  }

  double getProgress(){
    int medalsAchieved = super.getMedalsAchieved();
    int previousGoal = 0;
    if (medalsAchieved > 0 ){
      previousGoal = this.goals[medalsAchieved - 1];
    }
    if(medalsAchieved == super.getMedalAmount()){
      return 1.0;
    }
    int goal = this.goals[medalsAchieved];
    return
      (this.amountOfReceivedReviews - previousGoal) / (goal - previousGoal);
  }

}

/// Checks the number of recipes in the user's favourite list.
class CheckNumberOfFavourites extends CheckNumberSeries {

  int amountOfFavourites = 0;

  /// Constructor.
  CheckNumberOfFavourites(List<int> goals, List<Medal> medals)
      : super(goals, medals);

  void checkCurrentMedalAchieved(List<dynamic> objects) {
    // The input is a list of the user's favourite recipes.
    List<String> favourites = objects;
    this.amountOfFavourites = favourites.length;
    // If the amount of recipes is larger than the current goal...
    if (favourites.length >= this.goals[super.getMedalsAchieved()]){
      super.isAchieved();
    }
  }

  double getProgress(){
    int medalsAchieved = super.getMedalsAchieved();
    int previousGoal = 0;
    if (medalsAchieved > 0 ){
      previousGoal = this.goals[medalsAchieved - 1];
    }
    if(medalsAchieved == super.getMedalAmount()){
      return 1.0;
    }
    int goal = this.goals[medalsAchieved];
    return
      (this.amountOfFavourites - previousGoal) / (goal - previousGoal);
  }
}