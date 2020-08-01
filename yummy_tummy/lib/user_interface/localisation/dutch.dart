import 'package:yummytummy/user_interface/localisation/localization.dart';
import 'package:yummytummy/user_interface/screen_handler.dart';

import 'package:yummytummy/user_interface/profile_screen.dart';

import 'package:yummytummy/model/user.dart';

import 'package:yummytummy/model/recipe.dart';

import 'language.dart';

class Dutch extends Language {
  @override
  String appPageName(AppPage page) {
    switch(page) {
      case AppPage.feed:
        return 'Ontdekken';
        break;
      case AppPage.search:
        return 'Zoeken';
        break;
      case AppPage.favourites:
        return 'Favorieten';
        break;
      case AppPage.profile:
        return 'Profiel';
        break;
      case AppPage.none:
        return 'Geen';
        break;
    }
    return '';
  }

  @override
  String dietFieldName(DietField diet) {
    switch(diet)
    {
      case DietField.any:
        return 'Alles';
        break;
      case DietField.vegan:
        return 'Veganistisch';
        break;
      case DietField.vegetarian:
        return 'Vegetarisch';
        break;
    }
    return '';
  }

  @override
  String emptyProfilePageError(UserPage page) {
    switch(page)
    {
      case UserPage.medals:
        return 'Uw medailles zijn nog aan het laden.';
        break;
      case UserPage.recipes:
        return 'U heeft nog geen recepten aangemaakt!';
        break;
      case UserPage.reviews:
        return 'U heeft nog geen recept beoordeeld.';
        break;
    }
    return '';
  }

  @override
  String languageName(LanguagePick language) {
    switch( language )
    {
      case LanguagePick.english:
        return 'Engels';
        break;
      case LanguagePick.dutch:
        return 'Nederlands';
        break;
      case LanguagePick.other:
        return 'Anders';
        break;
    }
    return 'Niet ondersteund';
  }

  @override
  String profilePageName(UserPage page) {
    switch(page)
    {
      case UserPage.medals:
        return 'Medailles';
        break;
      case UserPage.recipes:
        return 'Recepten';
        break;
      case UserPage.reviews:
        return 'Reviews';
        break;
    }
    return '';
  }

  @override
  String rankName(RankType rank) {
    switch(rank)
    {
      case RankType.dishwasher:
        return 'Afwasser';
        break;
      case RankType.junior_chef:
        return 'Junior chef';
        break;
      case RankType.station_chef:
        return 'Station chef';
        break;
      case RankType.sous_chef:
        return 'Sous-chef';
        break;
      case RankType.head_chef:
        return 'Chef-kok';
        break;
      case RankType.executive_chef:
        return 'Executive chef';
        break;
    }
    return '';
  }

  @override
  String recipeTypeName(RecipeType type) {
    switch(type) {
      case RecipeType.any:
        return 'Alles';
        break;
      case RecipeType.soups:
        return 'Soepen';
        break;
      case RecipeType.salads:
        return 'Salades';
        break;
      case RecipeType.mains:
        return 'Hoofdgerechten';
        break;
      case RecipeType.desserts:
        return 'Desserten';
        break;
    }
    return '';
  }

  Dutch() : super({
      
      // General
      'type_here'             : 'Typ hier',
      'close_menu'            : 'Sluit menu',
      'submit'                : 'Indienen',
      'cancel'                : 'Annuleren',
      'set'                   : 'Zet',
      'add'                   : 'Voeg toe',
      'none'                  : 'Geen',
      'accept'                : 'Akkoord',
      'delete'                : 'Verwijder',

      // Units
      'hour_unit'             : 'u',
      'minute_unit'           : 'm',

      // Errors
      'recipe_database_error' : 'Er ging iets mis tijdens het laden van de recepten. Probeer opnieuw aub.',
      'no_bookmarks_yet'      : 'U heeft nog geen favorieten\n \n Voeg een recept toe aan je favorieten om deze hier te zien',
      'no_recipes_found'      : 'Er werden geen recepten gevonden, herbekijk uw zoekparameters aub',
      'author_not_found'      : 'Deze gebruiker bestaat niet of heeft nog geen recepten. Controlleer ook de hoofdletters aub.',
      'title_not_found'       : 'Er zijn geen recepten met deze titel gevonden.',
      'profile_login_error'   : 'Log in om uw profielpagina te zien.',
      'bookmarks_login_error' : 'Log in om uw opgeslagen recepten te zien.',

      // Favourite actions
      'undo_unfavourite'      : 'Dit recept wordt niet uit uw favorieten gehaald.',
      'unfavourite'           : 'Dit recept wordt binennkort verwijderd. Druk nogmaals op het icoon om deze actie ongedaan te maken',

      // Create recipe errors
      'error_no_title'        : 'Geef een titel op aub',
      'error_no_banner'       : 'Neem een bannerfoto aub',
      'error_short_descr'     : 'Maak de beschrijving iets langer aub',
      'error_no_type'         : 'Kies aub een type maaltijd voor dit recept',
      'error_no_ingredients'  : 'Voeg aub minstens één ingredient toe',
      'error_no_steps'        : 'Voeg aub minstens één stap toe',

      // Form/recipe language
      'search_recipes_title'  : 'Zoek naar recepten',
      'select_diet'           : 'Kies uw dieet',
      'select_course'         : 'Kies uw type maal',
      'ingredients'           : 'Ingrediënten',
      'ingredients_selector'  : 'Kies uw ingrediënten',
      'ingredients_hint'      : 'Voeg ingrediënten hier toe (optioneel)',
      'show_recipes'          : 'Zoek recepten',
      'step'                  : 'Stap',

      // Create recipe specific language
      'create_recipe'         : 'Maak een nieuw recept',
      'choose_title_here'     : 'Kies hier een titel voor dit recept',
      'title'                 : 'Titel',
      'description_here'      : 'Geef hier een korte beschrijving van het recept',
      'description'           : 'Beschrijving',
      'add_ingredient_hint'   : 'Voeg hier een ingrediënt toe',
      'set_course'            : 'Kies het type maal',
      'step_info_hint'        : 'Voeg hier info over een stap toe',
      'preparation_time'      : 'Bereidingsduur',
      'step_descriptions'     : 'Beschrijvingen van stappen',
      'created_recipe'        : 'Recept aangemaakt!',
      'thank_you_recipe'      : 'Hartelijk bedankt voor het maken van een nieuw recept!',
      'add_step'              : 'Voeg stap toe',
      'update_step'           : 'Update stap',

      // Review language
      'create_review_title'   : 'Beoordeel dit recept!',      
      'thank_you_review'      : 'Hartelijk bedankt voor het achterlaten van een beoordeling!',
      'please_leave_review'   : 'Laat aub een beoordeling achter voor dit recept.',
      'review_type_here'      : 'Voel u vrij om hier uw mening achter te laten',
      
      // Side menu language
      'search_by_user_title'  : 'Zoek recepten op maker',
      'search_by_user_hint'   : 'Gebruikersnaam hier (exacte match)',
      'search_by_recipe_title': 'Zoek recepten op titel',
      'search_by_title_hint'  : 'Geef de titel hier (exacte match)',
      'rank_overview_sidemenu': 'Informatie over ranks',
      'rank_overview_title'   : 'Dit is een overzicht van alle ranks en uw voortgang tot iedere rank.',
      'user_preferences'      : 'Persoonlijke voorkeuren',
      'select_language'       : 'Kies uw taal',

      // Delete recipe
      'delete_recipe_title'   : 'Recept verwijderen!',
      'delete_recipe_warning' : 'Klik akkoord om dit recept te verwijderen. Deze actie kan NIET ongedaan gemaakt worden.',

      // Seperate input
      'camera'                : 'Camera',
      'gallery'               : 'Gallerij',

      // Log in/out language
      'log_in_with_google'    : 'Log in met Google',
      'log_out_from_google'   : 'Log uit van Google',
    });
}