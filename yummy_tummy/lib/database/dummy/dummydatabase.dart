import 'package:yummytummy/database/interfaces/recipeService.dart';
import 'package:yummytummy/database/interfaces/reviewService.dart';
import 'package:yummytummy/database/interfaces/userService.dart';
import 'package:yummytummy/model/user.dart';
import 'package:yummytummy/model/review.dart';
import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/user_interface/localisation/localization.dart';

import '../query/queryInfo.dart';

class DummyDatabase implements RecipeService, ReviewService, UserService {
  
  final int delayInMilliseconds;

  /// DummyDatabase supports adding a delay after each request
  DummyDatabase({this.delayInMilliseconds = 0});

  /// Halt execution, await this method call!!
  Future<void> enforceDelay() async {
    return await Future.delayed(Duration(milliseconds: delayInMilliseconds));
  }

  // ---
  // RecipeService
  // ---

  /// Add a new recipe to the database. Returns the document ID.
  Future<String> addRecipe(Recipe recipe) async {
    await enforceDelay();
    return recipe.id;
  }

  /// Delete a recipe from the database when given a document ID.
  Future<void> deleteRecipe(String recipeID) async {
    await enforceDelay();
    return;
  }

  /// Returns recipe object from document ID.
  Future<Recipe> getRecipeFromID(String recipeID) async {
    await enforceDelay();
    return getRecipes()[0];
  }

  /// Modify an existing recipe with a given document ID.
  Future<void> modifyRecipe(Recipe recipe, String recipeID) async {
    await enforceDelay();
    return;
  }

  /// Returns all recipes made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Recipe>> getRecipesFromUser(UserMapField field, String value) async {
    await enforceDelay();
    return getRecipes();
  }

  /// Returns all recipes in the user's favourite list.
  Future<List<Recipe>> getFavouriteRecipes(User user) async {
    await enforceDelay();
    return getRecipes();
  }

  /// Returns all vegetarian recipes.
  Future<List<Recipe>> getVegetarianRecipes(SortField sortField) async {
    await enforceDelay();
    return getRecipes();
  }

  /// TEST METHOD
  /// lastDocument: Last document from where next records need to be fetched.
  Future<QueryInfo> queryTest(QueryInfo info, SortField sortField) async {
    //Note: Don't know if this will work yet.
    await enforceDelay();
    return QueryInfo();
  }

  /// Search recipes in the database by specifying fields.
  /// DietField: Recipes must match with a certain diet.
  /// SortField: Sort the acquired recipes.
  Future<RecipeQuery> searchRecipes(RecipeQuery info, SortField sortField, DietField dietField, RecipeType typeField, List<String> ingredients, {LanguagePick language}) async {
    await enforceDelay();
    return new RecipeQuery();
  }

  /// TEMPORARY: UI will use this method instead.
  /// Replace by searchRecipes when implementation is done.
  Future<List<Recipe>> searchRecipesUI(RecipeQuery info, SortField sortField) async {
    await enforceDelay();
    return getRecipes();
  }

  /// Update average and weighted rating in recipe document.
  Future<void> updateRatings(Review review) async {
    await enforceDelay();
  }

  // ---
  // ReviewService
  // ---

  /// Add a new review to the database. Returns the document ID.
  Future<String> addReview(Review review) async {
    await enforceDelay();
    return review.id;
  }

  /// Delete a review from the database when given a document ID.
  Future<void> deleteReview(String reviewID) async {
    await enforceDelay();
    return;
  }

  /// Modify an existing review with a given document ID.
  Future<void> modifyReview(Review review, String reviewID) async {
    await enforceDelay();
    return;
  }

  /// Returns review object from document ID.
  Future<Review> getReviewFromID(String reviewID) async {
    await enforceDelay();
    return getReviews()[0];
  }

  /// Returns all reviews made by a specific user.
  /// Field: Specify user by name or id.
  /// Value: Value of the field.
  Future<List<Review>> getReviewsFromUser(UserMapField field, String value) async {
    await enforceDelay();
    return getReviews();
  }

  /// Returns all reviews made for a specific recipe.
  Future<List<Review>> getReviewsFromRecipe(String recipeID) async {
    await enforceDelay();
    return getReviews();
  }

  // ---
  // UserService
  // ---

  /// Add a new user to the database. Returns the document ID.
  Future<String> addUser(User user, String userID) async {
    await enforceDelay();
    return user.id;
  }

  /// Returns user object from document ID.
  Future<User> getUserFromID(String userID) async {
    await enforceDelay();
    return getUsers()[0];
  }

  /// Modify an existing user with a given document ID.
  Future<void> modifyUser(User user, String userID) async {
    await enforceDelay();
  }

  /// Returns true if user exists.
  Future<bool> userExists(String userID) async {
    await enforceDelay();
    return true;
  }

  /// Listens to the app user's document for changes.
  void scoreListener(){
    print('listening..');
  }

  // ---
  // Dummy utility
  // ---

  List<Recipe> getRecipes() {
    return [
      Recipe(
        id: '0',
        title: 'Carpaccio van komkommer met geitenkaas',
        description:
          'Dit vegetarische voorgerecht is niet alleen lekker, maar ook een feest voor de ogen. Flinterdunne plakjes komkommer met staafjes appel, plakjes radijs en blokjes avocado. Daartussen komen toefjes geitenkaas die Jeroen op smaak brengt met wat bieslook en peper.',
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
        stepImages: {
          "1" : 'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
          "2" : 'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
        },
        rating: 4.6,
        duration: 40,
        image:
        'https://images.vrt.be/dako2017_1600s_j75/2018/04/26/edac70a0-492c-11e8-abcc-02b7b76bf47f.png',
        numberOfReviews: 0,
        userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.head_chef.index},
      ),
      Recipe(
        id: '1',
        title: 'Panna cotta met tartaar van kiwi en kokoscrumble',
        description:
        'Zó eenvoudig, maar ook zó lekker: panna cotta is een klassieker als nagerecht. Je hebt er niet veel werk aan, maar hou er rekening mee dat dit dessert minstens 2 uur nodig heeft om op te stijven. Dat geeft jou wel voldoende tijd om nog een heerlijke tartaar van kiwi en een kokoscrumble te maken.',
        type: RecipeType.mains,
        isVegetarian: false,
        isVegan: false,
        ingredients: [
          'gelatine',
          'melk',
          'room',
          'vanillestok',
        ],
        stepDescriptions: [
          'Leg de gelatineblaadjes in een beker met koud water en laat ze weken.',
          'Bereid het ‘infuus’ van melk en room. Melk absorbeert zeer gemakkelijk smaken en aroma’s. Meet de juiste hoeveelheden melk en room en doe ze samen in een pot of pan op een matig vuur.'
        ],
        stepImages: {
          "1" : 'https://images.vrt.be/dako2017_1600s_j75/2019/03/01/4289ca34-3bfa-11e9-abcc-02b7b76bf47f.jpg',
          "2" : 'https://images.vrt.be/dako2017_1600s_j75/2019/03/01/4289ca34-3bfa-11e9-abcc-02b7b76bf47f.jpg',
        },
        rating: 3.5,
        duration: 55,
        image:
        'https://images.vrt.be/dako2017_1600s_j75/2019/03/01/4289ca34-3bfa-11e9-abcc-02b7b76bf47f.jpg',
        numberOfReviews: 0,
        userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.head_chef.index},
      ),
      Recipe(
        id: '2',
        title: 'Cannelloni met gerookte zalm, asperges en spinazie',
        description:
        'Een cannelloni met het klassieke trio: zalm, spinazie en ricotta. Het pastagerecht past helemaal binnen dit seizoen dankzij de verrukkelijke asperges. Een toppertje dat gegarandeerd met open armen zal worden ontvangen thuis! ',
        type: RecipeType.mains,
        isVegetarian: false,
        isVegan: false,
        ingredients: [
          'asperge',
          'zout',
          'gerookte zalm',
        ],
        stepDescriptions: [
          'Verwarm de oven voor op 180°C.',
          'Zet een pot gezouten water op het vuur en doe er meteen de asperges in. Breng de asperges aan de kook.'
        ],
        stepImages: {
          "1" : 'https://images.vrt.be/dako2017_1600s_j75/2020/06/04/b108f8fd-a66e-11ea-aae0-02b7b76bf47f.jpg',
          "2" : 'https://images.vrt.be/dako2017_1600s_j75/2020/06/04/b108f8fd-a66e-11ea-aae0-02b7b76bf47f.jpg',
        },
        rating: 4.9,
        duration: 125,
        image:
        'https://images.vrt.be/dako2017_1600s_j75/2020/06/04/b108f8fd-a66e-11ea-aae0-02b7b76bf47f.jpg',
        numberOfReviews: 0,
        userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.head_chef.index},
      ),
      Recipe(
        id: '3',
        title: 'Secreto met gegrilde abrikozen en gebakken aardappelen',
        description:
        'Jeroen kookt vanop de Plaza Ochavada in het zonovergoten Archidona, waar hij aan de slag gaat met secreto. Dit prachtig stukje varkensvlees is doorspekt met vet en heeft daardoor ontzettend veel smaak. Serveer met gebakken aardappelen en een simpele fruitsalade.',
        type: RecipeType.mains,
        isVegetarian: false,
        isVegan: false,
        ingredients: [
          'aardappelen',
          'olijfolie',
          'knoflook',
        ],
        stepDescriptions: [
          'Verwarm de barbecue.',
          'Kook de aardappelen in de pel gaar in een pot gezouten water.'
        ],
        stepImages: {
          "1" : 'https://images.vrt.be/dako2017_1600s_j75/2018/07/26/a551d429-90df-11e8-abcc-02b7b76bf47f.jpg',
          "2" : 'https://images.vrt.be/dako2017_1600s_j75/2018/07/26/a551d429-90df-11e8-abcc-02b7b76bf47f.jpg',
        },
        rating: 2.5,
        duration: 25,
        image:
        'https://images.vrt.be/dako2017_1600s_j75/2018/07/26/a551d429-90df-11e8-abcc-02b7b76bf47f.jpg',
        numberOfReviews: 5,
        userMap: {'id' : 'id', 'name' : 'Michiel Proost', 'Rank' : RankType.head_chef.index},
      ),
    ];
  }

  List<Review> getReviews() {
    return [
      Review.userMap(
        {
          'id': '2',
          'name': 'Michiel',
          'score': 1500,
          'rank': RankType.junior_chef,
          'favourites': ['0', '1'],
        },
        id: '1',
        description: "Zeer tevreden van dit gerecht. Makkelijk te bereiden en écht super lekker!",
        rating: 4,
        recipeID: '1',
      ),
      Review.userMap(
        {
          'id': '2',
          'name': 'Michiel',
          'score': 1500,
          'rank': RankType.junior_chef,
          'favourites': ['0', '1'],
        },
        id: '2',
        description: "Dit is het lekkerste gerecht dat ik ooit heb gegeten",
        rating: 5,
        recipeID: '2',
      ),
            Review.userMap(
        {
          'id': '2',
          'name': 'Michiel',
          'score': 1500,
          'rank': RankType.junior_chef,
          'favourites': ['0', '1'],
        },
        id: '2',
        description: "Dit is het lekkerste gerecht dat ik ooit heb gegeten",
        rating: 5,
        recipeID: '2',
      ),
            Review.userMap(
        {
          'id': '2',
          'name': 'Michiel',
          'score': 1500,
          'rank': RankType.junior_chef,
          'favourites': ['0', '1'],
        },
        id: '2',
        description: "Dit is het lekkerste gerecht dat ik ooit heb gegeten",
        rating: 5,
        recipeID: '2',
      ),
            Review.userMap(
        {
          'id': '2',
          'name': 'Michiel',
          'score': 1500,
          'rank': RankType.junior_chef,
          'favourites': ['0', '1'],
        },
        id: '2',
        description: "Dit is het lekkerste gerecht dat ik ooit heb gegeten",
        rating: 5,
        recipeID: '2',
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
        rank: RankType.junior_chef,
        favourites: ['0', '1'],
      ),
      User(
        id: '3',
        name: 'Dieter',
        score: 500,
        rank: RankType.sous_chef,
        favourites: ['2'],
      ),
    ];
  }

  @override
  Future<List<Recipe>> getRecipesFromTitle(String title) async {
    await enforceDelay();
    return getRecipes();
  }

  @override
  Future<void> deleteProfilePicture(User user) async {
    await enforceDelay();
    return;
  }
}