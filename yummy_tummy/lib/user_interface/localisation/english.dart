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
        return 'Your medals are still loading.';
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
  
  English() : super({
      
      // General
      'type_here'             : 'Type here',
      'close_menu'            : 'Close menu',
      'submit'                : 'Submit',
      'cancel'                : 'Cancel',
      'set'                   : 'Set',
      'add'                   : 'Add',
      'none'                  : 'None',

      // Units
      'hour_unit'             : 'h',
      'minute_unit'           : 'm',

      // Errors
      'recipe_database_error' : 'Something went wrong while loading recipes',
      'no_bookmarks_yet'      : 'You have no bookmarked recipes yet\n \n Please favourite a recipe to store it here',
      'no_recipes_found'      : 'No recipes were found, please update your search parameters',
      'author_not_found'      : 'This user was not found or does not have any recipes',
      'title_not_found'       : 'No recipes with this title have been found.',
      'profile_login_error'   : 'Please log in to see your profile page.',
      'bookmarks_login_error' : 'Please log in to see your favourites.',

      // Favourite actions
      'undo_unfavourite'      : 'This recipe will not be removed from your favourites.',
      'unfavourite'           : 'This recipe will be removed soon. Press the bookmark action to undo.',

      // Create recipe errors
      'error_no_title'        : 'Please provide a recipe title',
      'error_no_banner'       : 'Please provide a recipe banner',
      'error_short_descr'     : 'Please provide a longer description',
      'error_no_type'         : 'Please indicate a course',
      'error_no_ingredients'  : 'Please include at least one ingredient',
      'error_no_steps'        : 'Please include at least one step',

      // Form/recipe language
      'search_recipes_title'  : 'Search for recipes',
      'select_diet'           : 'Choose your diet',
      'select_course'         : 'Pick your course',
      'ingredients'           : 'Ingredients',
      'ingredients_selector'  : 'Pick your ingredients',
      'ingredients_hint'      : 'Add required ingredients here (optional)',
      'show_recipes'          : 'Show recipes',
      'step'                  : 'Step',

      // Create recipe specific language
      'create_recipe'         : 'Create a new recipe',
      'choose_title_here'     : "Set the recipe's title here",
      'title'                 : "Title",
      'description_here'      : "Set the recipe's description here",
      'description'           : 'Description',
      'add_ingredient_hint'   : 'Add an ingredient here',
      'set_course'            : 'Set recipe type',
      'step_info_hint'        : 'Add step info here',
      'preparation_time'      : "Preparation time",
      'step_descriptions'     : 'Step descriptions',
      'created_recipe'        : 'Created a recipe!',
      'thank_you_recipe'      : 'Thank you for adding a new recipe!',
      'add_step'              : 'Add step',
      'update_step'           : 'Update step',

      // Review language
      'create_review_title'   : 'Rate this recipe!',      
      'thank_you_review'      : 'Thank you for creating a review!',
      'please_leave_review'   : 'Please leave a review for this recipe!',
      'review_type_here'      : 'Feel free to leave your opinion here',
      
      // Side menu language
      'search_by_user_title'  : 'Search recipes by creator',
      'search_by_user_hint'   : 'User name here (exact match)',
      'search_by_recipe_title': 'Search recipes by title',
      'search_by_title_hint'  : 'Recipe title here (exact match)',
      'rank_overview_sidemenu': 'Rank information',
      'rank_overview_title'   : 'This is an overview of all ranks and your progress towards them',
      'user_preferences'      : 'Personal preferences',

      // Seperate input
      'camera'                : 'Camera',
      'gallery'               : 'Gallery',

      // Log in/out language
      'log_in_with_google'    : 'Log in with Google',
      'log_out_from_google'   : 'Log out from Google',
    });

}