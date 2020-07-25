import 'package:yummytummy/model/board/medal.dart';

class Series {

  List<Medal> medals;
  int currentScore = 0;

  /// Constructor.
  Series({
    this.medals,
  });

  /// Return the next medal to be earned in this series.
  /// Returns null when there is no new medal to earn
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

  /// Return the highest received medal in this series.
  /// Returns null when no medal has been earned yet
  Medal getEarnedMedal() {
    int requiredScore = 0;
    Medal lastMedal;

    for (Medal medal in this.medals)
    {
      requiredScore += medal.score;
      if (currentScore >= requiredScore)
        lastMedal = medal;
      else
        return lastMedal;
    }

    return lastMedal;
  }

  /// When the collection's current medal is achieved..
  void isAchieved(){
    // Get current medal.
    Medal currentMedal = getCurrentMedal();
    // Update the series score.
    this.currentScore += currentMedal.score;
    // Medal is achieved.
    currentMedal.isAchieved();
  }

  /// Sets the series current score based on the amount of medals achieved.
  void setCurrentScore(int medalsAchieved){
    for( int i = 1; i <= medalsAchieved; i++){
      this.currentScore += medals[i].score;
    }
  }

  /// Returns the total amount of medals in this series
  int getMedalAmount()
  {
    return medals.length;
  }

  /// Get the amount of medals this series has received.
  int getMedalsAchieved(){
    return this.getCurrentMedal().medalType.index;
  }

  /// Print summary of series to console.
  void printSummary(){
    for (int i = 0; i < medals.length; i++){
      medals[i].printSummary();
    }
  }

}