import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/utils/stringFunctions.dart';

const BRONZE_VALUE = 250;
const SILVER_VALUE = 750;
const GOLD_VALUE = 1500;

const List<List<String>> titles = [
  ["Create your first recipe", "Create 3 recipes", "Create 10 recipes"],
  ["Write your first review", "Write 5 reviews", "Write 15 reviews"],
  ["Receive your first review", "Receive 5 reviews", "Receive 15 reviews"],
  ["Log in", "Share a recipe", "Add 3 recipes to your favourites list"],
];

/// Every medal is either bronze, silver or gold.
enum MedalType{
  bronze,
  silver,
  gold
}

/// Every series contains a bronze, silver and gold medal.
/// Every series becomes increasingly more difficult after each achieved medal.
enum SeriesType{
  create_recipes,
  write_reviews,
  receive_reviews,
  variety
}

extension seriesType on SeriesType{
  // Get a user-ready String of the series name.
  String getString()
  {
    return enumStringToDisplayString(this.toString());
  }
}

class Medal{

  final MedalType medalType;
  final SeriesType seriesType;
  final String title;
  bool achieved;

  Medal({
    this.medalType,
    this.seriesType,
    this.title,
    this.achieved,
  });

  isAchieved(){
    this.achieved = true;
    Constants.appUser.score += getMedalScore();
  }

  /// Get the medal's score based on its type.
  /// Returns 0 if something goes wrong.
  int getMedalScore(){

    switch (this.medalType){
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

  /// Print summary of medal to console.
  void printSummary(){
    print("Medal type: " + this.medalType.toString().split('.').last);
    print("Series type: " + this.seriesType.getString());
    print("Achieved: " + this.achieved.toString());
  }

}

/// Returns a list of predetermined medals.
/// earned: Tells the method which medals have been earned.
List<Medal> getMedals(List<bool> earned){

  List<Medal> medals = new List<Medal>();

  for (int i = 0; i < MedalType.values.length; i++){
    for (int j = 0; j < SeriesType.values.length; j++){
      Medal medal = new Medal(
        medalType: MedalType.values[i],
        seriesType : SeriesType.values[j],
        title: titles[j][i],
        achieved: earned[i+j],
      );
      medals.add(medal);
    }
  }
  return medals;

}

/// Transform a list of medals into a list of type bool.
List<bool> getAchievedList(List<Medal> medals){

  List<bool> achievedList = new List<bool>();
  for(int i = 0; i < medals.length; i++){
    achievedList.add(medals[i].achieved);
  }
  return achievedList;

}