import 'package:yummytummy/model/board/medal.dart';
import 'package:yummytummy/model/board/series.dart';

Map<String, Series> dataToSeriesMap(Map<String, dynamic> data){

  Map<String, Series> seriesMap = new Map<String, Series>();

  if (data.containsKey('create_recipes')) {
    // Create new series.
    Series create_recipes = new Series(
      medals: [ new Medal(MedalType.bronze, "Create your first recipe"),
                new Medal(MedalType.silver, "Create 3 recipes"),
                new Medal(MedalType.gold, "Create 5 recipes")],
    );
    create_recipes.setCurrentScore(data['create_recipes']);
    seriesMap['create_recipes'] = create_recipes;
  }

  if (data.containsKey('write_reviews')) {
    Series write_reviews = new Series(
      medals: [ new Medal(MedalType.bronze, "Write your first review"),
                new Medal(MedalType.silver, "Write 5 reviews"),
                new Medal(MedalType.gold, "Write 15 reviews")],
    );
    write_reviews.setCurrentScore(data['write_reviews']);
    seriesMap['write_reviews'] = write_reviews;
  }

  if (data.containsKey('receive_reviews')) {
    Series receive_reviews = new Series(
      medals: [ new Medal(MedalType.bronze, "Receive your first review"),
                new Medal(MedalType.silver, "Receive 5 reviews"),
                new Medal(MedalType.gold, "Receive 15 reviews")],
    );
    receive_reviews.setCurrentScore(data['receive_reviews']);
    seriesMap['receive_reviews'] = receive_reviews;
  }

  return seriesMap;

}

Map<String, Medal> dataToMedalMap(Map<String, dynamic> data){

  Map<String, Medal> medalsMap = new Map<String, Medal>();
  
  if(data.containsKey('login')) {
    Medal medal = new Medal(MedalType.bronze, "Log in");
    medal.achieved = data['login'];
    medalsMap['login'] = medal;
  }

  if(data.containsKey('add_favourite')) {
    Medal medal = new Medal(MedalType.silver, "Add 3 recipes to your favourites list");
    medal.achieved = data['add_favourite'];
    medalsMap['add_favourite'] = medal;
  }

  if(data.containsKey('share')) {
    Medal medal = new Medal(MedalType.gold, "Share a recipe with friends or family");
    medal.achieved = data['share'];
    medalsMap['share'] = medal;
  }

  return medalsMap;

}

Map<String, dynamic> seriesToDataMap(Map<String, Series> seriesMap){
  return {
    'create_recipes' : seriesMap.containsKey('create_recipes') ?
        seriesMap['create_recipes'].getMedalsAchieved() : 0,
    'write_reviews' : seriesMap.containsKey('write_reviews') ?
        seriesMap['write_reviews'].getMedalsAchieved() : 0,
    'receive_reviews' : seriesMap.containsKey('receive_reviews') ?
    seriesMap['receive_reviews'].getMedalsAchieved() : 0,
  };
}

Map<String, dynamic> medalToDataMap(Map<String, Medal> medalMap){
  return {
    'login' : medalMap.containsKey('login') ?
    medalMap['login'].achieved : false,
    'add_favourite' : medalMap.containsKey('add_favourite') ?
    medalMap['add_favourite'].achieved : false,
    'share' : medalMap.containsKey('share') ?
    medalMap['share'].achieved : false,
  };
}

Map<String, dynamic> getDefaultDataMap(){

  Map<String, dynamic> data = new Map<String, dynamic>();
  data['create_recipes'] = 0;
  data['write_reviews'] = 0;
  data['receive_reviews'] = 0;
  data['login'] = false;
  data['add_favourite'] = false;
  data['share'] = false;
  return data;

}