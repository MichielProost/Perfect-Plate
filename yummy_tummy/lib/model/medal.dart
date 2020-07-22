const BRONZE_VALUE = 250;
const SILVER_VALUE = 750;
const GOLD_VALUE = 1500;

/// Every medal is either bronze, silver or gold.
enum MedalType{
  bronze,
  silver,
  gold
}

class Medal{

  MedalType type;
  String title;

  Medal({
    this.type,
    this.title,
  });

  /// Get the medal's score based on its type.
  int getMedalScore(){

    switch (this.type){
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

  }

}