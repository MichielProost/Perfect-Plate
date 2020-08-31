import 'package:yummytummy/model/board/medal.dart';
import 'package:yummytummy/model/board/series/check_number_series.dart';
import 'package:yummytummy/model/board/series/series.dart';
import 'package:yummytummy/model/board/series/specific_series.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

/// Transform the received [data] map from Firebase into a [Series] map.
Map<String, Series> dataToSeriesMap(Map<String, dynamic> data){

  Localization.instance.language.getMessage("create_recipes_bronze");
  
  Map<String, Series> seriesMap = new Map<String, Series>();

  if (data.containsKey('create_recipes')) {
    // Create new series.
    Series create_recipes = new CheckNumberOfOwnRecipes(
      [1, 3, 5],
      [ new Medal(MedalType.bronze,
            Localization.instance.language.getMessage("create_recipes_bronze")),
        new Medal(MedalType.silver,
            Localization.instance.language.getMessage("create_recipes_silver")),
        new Medal(MedalType.gold,
            Localization.instance.language.getMessage("create_recipes_gold"))],
        Localization.instance.language.getMessage("create_recipes_series")
    );
    create_recipes.setCurrentScore(data['create_recipes']);
    seriesMap['create_recipes'] = create_recipes;
  }

  if (data.containsKey('write_reviews')) {
    Series write_reviews = new CheckNumberOfOwnReviews(
        [1, 5, 15],
        [ new Medal(MedalType.bronze,
              Localization.instance.language.getMessage("write_reviews_bronze")),
          new Medal(MedalType.silver,
              Localization.instance.language.getMessage("write_reviews_silver")),
          new Medal(MedalType.gold,
              Localization.instance.language.getMessage("write_reviews_gold"))],
        Localization.instance.language.getMessage("write_reviews_series")
    );
    write_reviews.setCurrentScore(data['write_reviews']);
    seriesMap['write_reviews'] = write_reviews;
  }

  if (data.containsKey('receive_reviews')) {
    Series receive_reviews = new CheckNumberOfReceivedReviews(
        [1, 5, 15],
        [ new Medal(MedalType.bronze,
              Localization.instance.language.getMessage("receive_reviews_bronze")),
          new Medal(MedalType.silver,
              Localization.instance.language.getMessage("receive_reviews_silver")),
          new Medal(MedalType.gold,
              Localization.instance.language.getMessage("receive_reviews_gold"))],
        Localization.instance.language.getMessage("receive_reviews_series")
    );
    receive_reviews.setCurrentScore(data['receive_reviews']);
    seriesMap['receive_reviews'] = receive_reviews;
  }

  if (data.containsKey('login')) {
    Series login = new CheckLoginSeries(
        [ new Medal(MedalType.bronze,
              Localization.instance.language.getMessage("log_in_medal")) ],
        Localization.instance.language.getMessage("login_series")
    );
    login.setCurrentScore(data['login']);
    seriesMap['login'] = login;
  }

  if (data.containsKey('add_favourite')) {
    Series login = new CheckNumberOfFavourites(
        [3],
        [ new Medal(MedalType.silver,
            Localization.instance.language.getMessage("add_favourite_medal")) ],
        Localization.instance.language.getMessage("add_favourite_series")
    );
    login.setCurrentScore(data['add_favourite']);
    seriesMap['add_favourite'] = login;
  }

  if (data.containsKey('preference')) {
    Series preference = new CheckPreferenceSeries(
        [ new Medal(MedalType.gold,
            Localization.instance.language.getMessage("preference_medal")) ],
        Localization.instance.language.getMessage("preference_series")
    );
    preference.setCurrentScore(data['preference']);
    seriesMap['preference'] = preference;
  }

  return seriesMap;

}

/// Transform the internal [Series] map into a data map for Firebase.
Map<String, dynamic> seriesToDataMap(Map<String, Series> seriesMap){
  return {
    'create_recipes' : seriesMap.containsKey('create_recipes') ?
        seriesMap['create_recipes'].getMedalsAchieved() : 0,
    'write_reviews' : seriesMap.containsKey('write_reviews') ?
        seriesMap['write_reviews'].getMedalsAchieved() : 0,
    'receive_reviews' : seriesMap.containsKey('receive_reviews') ?
        seriesMap['receive_reviews'].getMedalsAchieved() : 0,
    'login' : seriesMap.containsKey('login') ?
        seriesMap['login'].getMedalsAchieved() : 0,
    'add_favourite' : seriesMap.containsKey('add_favourite') ?
        seriesMap['add_favourite'].getMedalsAchieved() : 0,
    'preference' : seriesMap.containsKey('preference') ?
        seriesMap['preference'].getMedalsAchieved() : 0,
  };
}

/// The default data map for storing the provided [Series] in Firebase.
Map<String, dynamic> getDefaultDataMap(){

  Map<String, dynamic> data = new Map<String, dynamic>();
  data['create_recipes'] = 0;
  data['write_reviews'] = 0;
  data['receive_reviews'] = 0;
  data['login'] = 0;
  data['add_favourite'] = 0;
  data['preference'] = 0;
  return data;

}