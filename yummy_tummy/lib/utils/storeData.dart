/// Temporary database awaiting Firestore implementation.

import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

/// Returns a list of recipes.
List<Recipe> getRecipes() {
  return [
    Recipe(
      id: '0',
      title: 'Carpaccio van komkommer met geitenkaas',
      rating: 4.6,
      description:
        'Dit vegetarische voorgerecht is niet alleen lekker, maar ook een feest voor de ogen. Flinterdunne plakjes komkommer met staafjes appel, plakjes radijs en blokjes avocado. Daartussen komen toefjes geitenkaas die Jeroen op smaak brengt met wat bieslook en peper.',
      type: RecipeType.lunch,
      isVegetarian: true,
      duration: 40,
      ingredients: [
        'zachte geitenkaas zonder korst',
        'komkommer',
        'avocado',
        'groene appel',
        'radijs',
        'bieslook',
      ],
      imageURL:
        'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
    ),
    Recipe(
      id: '1',
      title: 'Vlaamse wafels met vanilleshake',
      rating: 3.8,
      description:
        'Vlaamse wafels bakken wordt een koud kunstje dankzij dit authentieke recept van Jeroen. Een lekker tussendoortje om het weekend goed in te zetten!',
      type: RecipeType.desserts,
      isVegetarian: false,
      duration: 30,
      ingredients: [
        'boter',
        'bloem',
        'eieren',
        'melk',
        'kristalsuiker',
        'vanille-ijs',
      ],
      imageURL:
        'https://images.vrt.be/dako2017_1200s630_j70/2020/06/11/196fd3f2-abde-11ea-aae0-02b7b76bf47f.jpg'
    ),
    Recipe(
      id: '2',
      title: 'Varkensgebraad met gegratineerde aardappelen',
      rating: 3.9,
      description:
        'Een klassiek stuk varkensgebraad wordt altijd gesmaakt, zeker met sjalot, rozemarijn en blond bier.',
      type: RecipeType.lunch,
      isVegetarian: true,
      duration: 40,
      ingredients: [
        'zachte geitenkaas zonder korst',
        'komkommer',
        'avocado',
        'groene appel',
        'radijs',
        'bieslook',
      ],
      imageURL:
        'https://images.vrt.be/dako2017_1600s_j75/2017/03/06/0dd6b922-024e-11e7-8f5f-00163edf48dd.jpg',
    ),
    Recipe(
      id: '3',
      title: 'Gevulde aardappel met ei, spek en kaas',
      rating: 1.4,
      description:
        'Met witte en groene asperges en een stukje krokant gebakken spek erbij, is dit een perfect voorgerecht.',
      type: RecipeType.lunch,
      isVegetarian: true,
      duration: 40,
      ingredients: [
        'zachte geitenkaas zonder korst',
        'komkommer',
        'avocado',
        'groene appel',
        'radijs',
        'bieslook',
      ],
      imageURL:
        'https://images.vrt.be/dako2017_1600s_j75/2018/04/30/58ba254b-4c7c-11e8-abcc-02b7b76bf47f.png',
    ),
  ];
}

/// Returns a list of users.
List<User> getUsers(){
  return [
    User(
      id: '2',
      name: 'Michiel',
      score: 1500,
      rank: RankType.amateur,
    ),
    User(
      id: '3',
      name: 'Dieter',
      score: 500,
      rank: RankType.beginner,
    ),
  ];
}