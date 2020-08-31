import 'package:yummytummy/database/firestore/userServiceFirestore.dart';
import 'package:yummytummy/user_interface/constants.dart';

const BRONZE_VALUE = 250;
const SILVER_VALUE = 750;
const GOLD_VALUE = 1500;

/// Every [Medal] is either bronze, silver or gold.
enum MedalType{
  bronze,
  silver,
  gold
}

class Medal{

  final MedalType medalType;
  final String title;
  int score;
  bool achieved = false;

  /// Constructor.
  Medal(this.medalType, this.title){
    score = getMedalScore(medalType);
  }

  /// When the user's [Medal] is achieved..
  isAchieved(){
    achieved = true;

    // Update user's score.
    Constants.appUser.score += score;

    // Update App User with new information.
    UserServiceFirestore userService = new UserServiceFirestore();
    userService.modifyUser(Constants.appUser, Constants.appUser.id);
  }

  /// Get the [Medal]'s score based on its type.
  /// Returns 0 if something goes wrong.
  int getMedalScore(MedalType medalType){

    switch (medalType){
      case MedalType.bronze:
        return BRONZE_VALUE;
      break;
      case MedalType.silver:
        return SILVER_VALUE;
      break;
      case MedalType.gold:
        return GOLD_VALUE;
      break;
    }
    return 0;

  }

  /// Print summary of [Medal] to console.
  void printSummary(){
    print("Medal type: " + this.medalType.toString().split('.').last);
    print("Title: " + this.title);
  }

}