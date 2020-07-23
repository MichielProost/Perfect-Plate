import 'package:yummytummy/user_interface/constants.dart';
import 'package:yummytummy/utils/stringFunctions.dart';

const JUNIOR_LIM = 2000;
const STATION_LIM = 4000;
const SOUS_LIM = 6000;
const HEAD_LIM = 8000;
const EXECUTIVE_LIM = 10000;

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
    return index < RankType.values.length ? RankType.values[index] : RankType.values[ RankType.values.length-1 ];
  }

  // Get a user-ready String of the rank name
  String getString()
  {
    //TODO implement better way to implement this with regards to languages
    String lowercase = this.toString().toLowerCase().split('.').last;
    if (lowercase.contains("_")){
      int index = lowercase.indexOf("_");
      lowercase = replaceCharAt(lowercase, index, " ");
    }
    return '${lowercase[0].toUpperCase()}${lowercase.substring(1)}';
  }

}

class User{

  final String id;                // Document ID.
  String name;                    // Name of user.
  int score;                      // User's total score.
  RankType rank;                  // User's rank.
  List<String> favourites;        // Document IDs of user's favourite recipes.
  String image;

  User({
    this.id,
    this.name,
    this.score,
    this.rank,
    this.favourites,
    this.image,
  });

  /// Deserialize received data from Firestore.
  /// Initialize a new user object.
  User.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id != null ? id : data['id'],
          name: data.containsKey('name') ? data['name'] : '',
          score: data.containsKey('score') ? data['score'] : 0,
          rank: data.containsKey('rank') ? RankType.values[data['rank']] : RankType.dishwasher,
          favourites: data.containsKey('favourites') ?
            new List<String>.from(data['favourites']) : [],
          image: data.containsKey('image') ? data['image'] : '',
        );

  /// Modify non-final fields of user.
  void setUser(User user){
    this.name = name;
    this.score = score;
    this.rank = rank;
    this.favourites = favourites;
    this.image = image;
  }

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return  {
      'name' : name != null ? name : '',
      'score' : score != null ? score : '',
      'rank' : rank != null ? rank.index : RankType.dishwasher.index,
      'favourites' : favourites != null ? favourites : [],
      'image' : image??= '',
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

    switch (type) {
      case RankType.junior_chef:
        return JUNIOR_LIM;
        break;
      case RankType.station_chef:
        return STATION_LIM;
        break;
      case RankType.sous_chef:
        return SOUS_LIM;
        break;
      case RankType.head_chef:
        return HEAD_LIM;
        break;
      case RankType.executive_chef:
        return EXECUTIVE_LIM;
        break;
    }

  }

  /// Print summary of user to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Name: " + this.name);
  }

}