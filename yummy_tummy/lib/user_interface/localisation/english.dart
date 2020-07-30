import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/localisation/language.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';
import 'package:yummytummy/user_interface/profile_screen.dart';

class English extends Language {
  
  @override
  String appPageName(AppPage page) {
    switch(page) {
      case AppPage.feed:
        return 'Feed';
        break;
      case AppPage.search:
        return 'Search';
        break;
      case AppPage.favourites:
        return 'Favourites';
        break;
      case AppPage.profile:
        return 'Profile';
        break;
      case AppPage.none:
        return 'None';
        break;
    }
    return '';
  }

  @override
  String rankName(RankType rank){
    return rank.getString();
  }

  @override
  String dietFieldName(DietField diet){
    return diet.getString();
  }

  @override
  String recipeTypeName(RecipeType type){
    return type.getString();
  }

  @override
  String profilePageName(UserPage page){
    return page.getString();
  }

  @override
  String emptyProfilePageError(UserPage page)
  {
    switch(page){
      case UserPage.medals:
        return 'Your medals are still loading';
        break;
      case UserPage.recipes:
        return "You haven't published any recipes yet!";
        break;
      case UserPage.reviews:
        return "You haven't published any reviews yet!";
        break;
    }
    return '';
  }

  @override
  String getMessage(String messageName) {
    return super.messages.containsKey( messageName.toLowerCase() ) ?
      super.messages[ messageName.toLowerCase() ] :
      messageName;
  }
  
  English()
  {
    super.messages.addAll({
      'type_here'             : 'Type here',
      'close_menu'            : 'Close menu',
      'recipe_database_error' : 'Something went wrong while loading recipes',
      'no_bookmarks_yet'      : 'You have no bookmarked recipes yet\n \n Please favourite a recipe to store it here',
      'no_recipes_found'      : 'No recipes were found, please update your search parameters',
      'search_recipes_title'  : 'Search for recipes',
      'select_diet'           : 'Choose your diet',
      'select_course'         : 'Pick your course',
      'ingredients'           : 'Ingredients',
      'ingredients_selector'  : 'Pick your ingredients',
      'submit'                : 'Submit',
      'cancel'                : 'Cancel',
      'thank_you_review'      : 'Thank you for creating a review!',
      'please_leave_review'   : 'Please leave a review for this recipe!',
      'step'                  : 'Step',
      'author_not_found'      : 'This user was not found or does not have any recipes',
      'search_by_user_title'  : 'Search recipes by creator',
      'rank_overview_title'   : 'This is an overview of all ranks and your progress toward them',
      'user_preferences'      : 'Personal preferences',
      'profile_login_error'   : 'Please log in to see your profile page',
    });
  }

}