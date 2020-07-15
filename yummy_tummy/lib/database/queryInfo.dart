import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/recipe.dart';

/// Store query information.
class QueryInfo {

  DocumentSnapshot lastDocument; // Last document from where next records need to be fetched.
  bool hasMore; // Flag for more documents available or not.

  /// Constructor.
  QueryInfo(){
    lastDocument = null;
    hasMore = true;
  }

}

class RecipeQuery extends QueryInfo{

  List<Recipe> recipes; // Stores fetched recipes.

  /// Constructor.
  RecipeQuery(){
    recipes = [];
  }

}