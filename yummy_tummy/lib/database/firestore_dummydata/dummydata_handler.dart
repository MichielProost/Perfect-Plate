

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yummytummy/database/firestore/recipeServiceFirestore.dart';
import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

class DummyDataHandler {
  
  final String description = 'placeholder';

  void createDummyRecipes(int amount) async
  {
    QuerySnapshot q = await Firestore.instance.collection('recipes').where( 'description', isEqualTo: description).getDocuments();
    if (q.documents.length == 0)
    {
      print('Creating new dummy recipes in Firestore');
      RecipeService recipeService = RecipeServiceFirestore();
      for (int i = 0; i < amount; i++)
      {
        await recipeService.addRecipe( _createDummyRecipe( i ) );
      }
      print('Done creating dummies');
    } else {
      print('No dummy recipes created, please delete the previous series first');
    }
  }

  void deleteDummyRecipes() async {
    print('Deleting dummy recipes');
    QuerySnapshot query = await Firestore.instance.collection('recipes').where( 'description', isEqualTo: description).getDocuments();
    for (DocumentSnapshot doc in query.documents)
    {
      await doc.reference.delete();
    }
    print('Deleting dummy recipes complete');
  }

  Recipe _createDummyRecipe(int index)
  {
    return Recipe(
      title: 'Recipe $index',
      description:
        description,
      type: RecipeType.salads,
      isVegetarian: true,
      isVegan: true,
      ingredients: [
        'zachte geitenkaas zonder korst',
        'komkommer',
        'avocado',
        'groene appel',
        'radijs',
        'bieslook',
      ],
      stepDescriptions: [
        'Verwarm de oven voor tot 200 °C.',
        'Snijd de ciabatta in zo dun mogelijke plakjes met een gekarteld mes.'
      ],
      stepImages: [
        'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
        'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
      ],
      rating: 4.6,
      duration: 40,
      image:
      'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
      numberOfReviews: 0,
      userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.head_chef.index},
    );
  }

}