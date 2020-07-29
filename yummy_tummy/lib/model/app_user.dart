import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

/// A class that contains info on a logged in user
class AppUser extends User {

  // For internal usage
  final String _googleID;

  // Preferences
  // TODO implement a way for user to set preferences
  DietField dietFieldPreference = DietField.any;
  RecipeType recipeTypePreference = RecipeType.mains;

  AppUser(this._googleID, Map<String, dynamic> userData) : super.fromMap( userData, _googleID );

  AppUser.offline() : _googleID = "", super(id: "", name: "User", rank: RankType.values[0], score: 0, favourites: List<String>());

  /// Check if this user is logged in
  bool isLoggedIn()
  {
    return _googleID != "";
  }

}