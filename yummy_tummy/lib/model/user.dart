import 'package:yummytummy/model/board/medal_board.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/utils/stringFunctions.dart';

// const JUNIOR_LIM = 2000;
// const STATION_LIM = 4000;
// const SOUS_LIM = 6000;
// const HEAD_LIM = 8000;
// const EXECUTIVE_LIM = 10000;

const Map<RankType, int> rankupMap = {
  RankType.dishwasher: 0,
  RankType.junior_chef: 2000,
  RankType.station_chef: 4000,
  RankType.sous_chef: 6000,
  RankType.head_chef: 8000,
  RankType.executive_chef: 10000,
};

// The Recipe and Review Class contain a UserMap.
// This map contains the most important information of the user.
enum UserMapField{
  id,
  name
}

// The rank a specific user can have.
enum RankType {
  dishwasher,
  junior_chef,
  station_chef,
  sous_chef,
  head_chef,
  executive_chef,
}

extension Rank on RankType {

  /// Get the corresponding rank of this index.
  /// Must be >= 0.
  /// An index that is too high will simply result in the highest rank.
  RankType getRank(int index)
  {
    if (index == null)
      return RankType.values[0];
    return index < RankType.values.length ? RankType.values[index] : RankType.values[ RankType.values.length-1 ];
  }

  /// Get the next rank in line
  /// Will be null if there is no next rank available
  RankType getNextRank()
  {
    return RankType.values.length-1 > this.index ? RankType.values[ this.index + 1 ] : null;
  }

  /// Get the required score to achieve this rank
  /// Will be 0 if the rank doesn't have a mapped score
  int getRequiredScore()
  {
    return rankupMap.containsKey( this ) ? rankupMap[ this ] : 0;
  }

  // Get a user-ready String of the rank name
  String getString()
  {
    return enumStringToDisplayString(this.toString());
  }

}

class User{

  final String id;                // Document ID.
  String name;                    // Name of user.
  int score;                      // User's total score.
  RankType rank;                  // User's rank.
  List<String> favourites;        // Document IDs of user's favourite recipes.
  String image;                   // User's profile picture.
  MedalBoard board;               // User's medal board.

  // Preferences
  DietField dietFieldPreference = DietField.any;
  RecipeType recipeTypePreference = RecipeType.any;
  LanguagePick languagePreference = LanguagePick.other;

  User({
    this.id,
    this.name,
    this.score,
    this.rank,
    this.favourites,
    this.image,
    this.board,
    this.dietFieldPreference,
    this.recipeTypePreference,
    this.languagePreference,
  });

  /// Deserialize received data from Firestore.
  /// Initialize a new user object.
  User.fromMap(Map<String, dynamic> data, String id) :
        this.id = id != null ? id : data['id'],
        this.name = data.containsKey('name') ? data['name'] : '',
        this.dietFieldPreference = data.containsKey('dietFieldPreference') ?
        DietField.values[ data['dietFieldPreference']] : DietField.any,
        this.recipeTypePreference = data.containsKey('recipeTypePreference') ?
        RecipeType.values[data['recipeTypePreference']] : RecipeType.any,
        this.languagePreference = data.containsKey('languagePreference') ?
        LanguagePick.values[data['languagePreference']] : LanguagePick.other,
        this.score = data.containsKey('score') ? data['score'] : 0,
        this.rank = data.containsKey('rank') ? RankType.values[data['rank']] : RankType.dishwasher,
        this.favourites = data.containsKey('favourites') ?
        new List<String>.from(data['favourites']) : [],
        this.image = data.containsKey('image') ? data['image'] : ''
        {
          Localization.instance.setLanguage( languagePreference );
          this.board = data.containsKey('board') ?
          MedalBoard.fromMap(Map<String, dynamic>.from(data['board'])) : null;
        }

  /// Modify non-final fields of user.
  void setUser(User user){
    this.name                 = user.name;
    this.score                = user.score;
    this.rank                 = user.rank;
    this.favourites           = user.favourites;
    this.image                = user.image;
    this.board                = user.board;
    this.dietFieldPreference  = user.dietFieldPreference;
    this.recipeTypePreference = user.recipeTypePreference;
    this.languagePreference   = user.languagePreference;
  }

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return  {
      'name' : name != null ? name : '',
      'score' : score != null ? score : '',
      'rank' : rank != null ? rank.index : RankType.dishwasher.index,
      'favourites' : favourites != null ? favourites : [],
      'dietFieldPreference' : dietFieldPreference.index,
      'recipeTypePreference' : recipeTypePreference.index,
      'languagePreference' : languagePreference.index,
      'image' : image??= '',
      'board' : board != null ? board.toMap() : {},
    };
  }

  Map<String, dynamic> toCompactMap(){
    return {
      'id' : id != null ? id : '',
      'name' : name != null ? name : '',
      'rank' : rank != null ? rank.index : RankType.dishwasher.index,
    };
  }

  RankType getNextRank(RankType type) {
    return type.getRank(type.index + 1);
  }

  /// Check if this user has the possibility of gaining another rank
  bool hasNextRank()
  {
    return rank.index < RankType.values.length-1;
  }

  /// Upgrade user to the next rank.
  void upgradeRank(){
    this.rank = getNextRank(this.rank);
  }

  /// Checks if the user's rank can be upgraded.
  bool checkRankUpgrade(){

    if (this.score >=
        this.getRankLimit(getNextRank(this.rank))){
      return true;
    }
    return false;

  }

  /// Get the medal's score based on its type.
  int getRankLimit(RankType type) {
    return type.getRequiredScore();
  }

  /// Print summary of user to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Name: " + this.name);
  }

}