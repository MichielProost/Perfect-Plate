import 'package:yummytummy/model/board/medal.dart';

class Series {

  List<Medal> medals;
  int currentScore = 0;

  /// Constructor.
  Series({
    this.medals,
  });

  /// Return the highest received medal in this series.
  /// Returns null when something goes wrong.
  Medal getCurrentMedal() {
    int requiredScore = 0;
    for (int i = 0; i < this.medals.length; i++) {
      requiredScore += this.medals[i].score;
      if (currentScore < requiredScore){
        return this.medals[i];
      }
    }
    return null;
  }

  /// When the collection's current medal is achieved..
  isAchieved(){
    // Get current medal.
    Medal currentMedal = getCurrentMedal();
    // Update the series score.
    this.currentScore += currentMedal.score;
    // Medal is achieved.
    currentMedal.isAchieved();
  }

  /// Sets the series current score based on the amount of medals achieved.
  setCurrentScore(int medalsAchieved){
    for( int i = 1; i <= medalsAchieved; i++){
      this.currentScore += medals[i].score;
    }
  }

  /// Get the amount of medals this series has received.
  getMedalsAchieved(){
    return this.getCurrentMedal().medalType.index;
  }

  /// Print summary of series to console.
  printSummary(){
    for (int i = 0; i < medals.length; i++){
      medals[i].printSummary();
    }
  }

}