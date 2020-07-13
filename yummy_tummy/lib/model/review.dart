import 'package:yummytummy/model/user.dart';

class Review{

  final String id;                      // Document ID.
  final User user;                      // User object.
  final Map<String, dynamic> userMap;   // Duplicate data. Information of user.
  final String recipeID;                // Recipe ID.
  final int rating;                     // Rating from user.
  final String description;             // Description from user.

  const Review({
    this.id = '',
    this.user,
    this.userMap,
    this.recipeID = '',
    this.rating = 0,
    this.description = '',
  });

  Review.userMap(
    this.userMap,
    {
      this.id = '',
      this.recipeID = '',
      this.rating = 0,
      this.description = ''
    }
  ) : user = User.fromMap(userMap, null);

  Review.user(
    this.user,  
    {
      this.id = '',
      this.recipeID = '',
      this.rating = 0,
      this.description = '',
      // TODO retreive usermap from given user field
    }
  ) : userMap = Map<String, dynamic>();

  /// Deserialize received data from Firestore.
  /// Initialize a new review object.
  Review.fromMap(Map<String, dynamic> data, String id)
      : this(
          id: id,
          user: data.containsKey('userMap') ?
            User.fromMap( Map<String, dynamic>.from(data['userMap']), null) : User(id: '', name: '', rank: RankType.amateur),
          userMap: data.containsKey('userMap') ?
            new Map<String, dynamic>.from(data['userMap']) : {},
          recipeID: data.containsKey('recipeID') ? data['recipeID'] : '',
          rating: data.containsKey('rating') ? data['rating'] : 0,
          description: data.containsKey('description') ? data['description'] : '',
      );

  /// Convert class object to data structure 'Map'.
  Map<String, dynamic> toMap() {
    return {
      'userMap' : userMap != null ? userMap : {},
      'recipeID' : recipeID != null ? recipeID : '',
      'rating' : rating != null ? rating : 0.0,
      'description' : description != null ? description : '',
    };
  }

  /// Print summary of review to console.
  void printSummary(){
    print("Document ID: " + this.id);
    print("Recipe ID: " + this.recipeID);
    print("Rating: $rating");
  }

}