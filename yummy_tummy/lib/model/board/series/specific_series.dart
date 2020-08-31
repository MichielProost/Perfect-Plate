import 'package:yummytummy/model/board/series/series.dart';
import 'package:yummytummy/model/board/medal.dart';
import 'package:yummytummy/user_interface/constants.dart';

/// Checks if the user is logged in.
class CheckLoginSeries extends Series {

  /// Constructor.
  CheckLoginSeries(List<Medal> medals, String title)
      : super(medals, title);

  /// [objects] : Should be an empty list [].
  void checkCurrentMedalAchieved(List<dynamic> objects){
    if (Constants.appUser.isLoggedIn()){
      super.isAchieved();
    }
  }

  double getProgress(){
    // Get the amount of achieved medals.
    int medalsAchieved = super.getMedalsAchieved();
    if (medalsAchieved == 0){
      return 0.0;
    } else if (medalsAchieved >= 1){
      return 1.0;
    }
    return 1.0;
  }

}

class CheckPreferenceSeries extends Series {

  /// Constructor.
  CheckPreferenceSeries(List<Medal> medals, String title)
      : super(medals, title);

  /// [objects] : Should be an empty list [].
  void checkCurrentMedalAchieved(List<dynamic> objects){
    super.isAchieved();
  }

  double getProgress(){
    // Get the amount of achieved medals.
    int medalsAchieved = super.getMedalsAchieved();
    if (medalsAchieved == 0){
      return 0.0;
    } else if (medalsAchieved >= 1){
      return 1.0;
    }
    return 1.0;
  }

}