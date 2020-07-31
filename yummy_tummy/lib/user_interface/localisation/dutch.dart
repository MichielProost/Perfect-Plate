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
        return 'Ontdek';
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
    'type_here'             : 'Typ hier',
    'close_menu'            : 'Sluit menu',
    'recipe_database_error' : 'Er ging iets mist tijdens het laden van de recepten',
    'no_bookmarks_yet'      : 'U heeft nog geen opgeslagen reccepten\n \n Markeer aub een recept als favoriet om het hier op te slaan',
    'no_recipes_found'      : 'Er werden geen recepten gevonden, wijzig uw zoekparameters aub',
    'search_recipes_title'  : 'Zoek naar recepten',
    'select_diet'           : 'Kies uw diëet',
    'select_course'         : 'Kies uw maal',
    'ingredients'           : 'Ingrediënten',
    'ingredients_selector'  : 'Kies uw ingrediënten',
    'ingredients_hint'      : 'Voeg hier ingrediënten toe (optioneel)',
    'submit'                : 'Indienen',
    'show_recipes'          : 'Zoek recepten',
    'cancel'                : 'Annuleren',
    'thank_you_review'      : 'Hartelijk bedankt voor het aanmaken van een beoordeling!',
    'please_leave_review'   : 'Laat aub een beoordeling achter voor dit recept.',
    'step'                  : 'Stap',
    'author_not_found'      : 'Deze gebruiker bestaat niet of heeft nog geen recepten gepubliceerd.',
    'search_by_user_title'  : 'Zoek recepten van een maker',
    'search_by_user_hint'   : 'Gebruikersnaam hier (exacte match)',
    'rank_overview_title'   : 'Dit is een overzicht van alle ranks en uw voortgang tot iedere rank.',
    'user_preferences'      : 'Persoonlijke voorkeuren',
    'profile_login_error'   : 'Log eerst in om uw profielpagina te kunnen bekijken',
    'bookmarks_login_error' : 'Please log in to see your favourites.',
  });
}