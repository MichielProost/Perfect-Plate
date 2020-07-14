import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/model/recipe.dart';

/// Store query information.
class QueryInfo {

  List objects; // Stores fetched objects.
  DocumentSnapshot lastDocument; // Last document from where next records need to be fetched.
  bool hasMore; // Flag for more documents available or not.

  /// Constructor.
  QueryInfo(){
    objects = [];
    lastDocument = null;
    hasMore = true;
  }

}