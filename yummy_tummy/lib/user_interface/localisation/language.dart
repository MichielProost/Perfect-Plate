import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/user_interface/profile_screen.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';

abstract class Language {

  final Map<String, String> _messages;

  Language(this._messages);

  /// Localised names of each page.
  String appPageName(AppPage page);

  /// Localised name of each rank.
  String rankName(RankType rank);

  /// Localised name of each diet.
  String dietFieldName(DietField diet);

  /// Localised name of each course.
  String recipeTypeName(RecipeType type);
  
  /// Used for profile page names.
  String profilePageName(UserPage page);

  /// When a user is on a profile page but it has no elements (no created recipes, reviews, ...).
  String emptyProfilePageError(UserPage page);

  /// Get any other message.
  String getMessage(String messageName) {
    return _messages.containsKey( messageName.toLowerCase() ) ?
      _messages[ messageName.toLowerCase() ] :
      messageName;
  }


}