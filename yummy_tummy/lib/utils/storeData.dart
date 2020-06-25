/// Temporary database awaiting Firestore implementation.

import 'package:yummytummy/model/recipe.dart';
import 'package:yummytummy/model/user.dart';

/// Returns a list of recipes.
List<Recipe> getRecipes() {
  return [
    Recipe(
      id: '0',
      title: 'Carpaccio van komkommer met geitenkaas',
      description:
        'Dit vegetarische voorgerecht is niet alleen lekker, maar ook een feest voor de ogen. Flinterdunne plakjes komkommer met staafjes appel, plakjes radijs en blokjes avocado. Daartussen komen toefjes geitenkaas die Jeroen op smaak brengt met wat bieslook en peper.',
      type: RecipeType.salads,
      isVegetarian: true,
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
      userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.amateur.index},
    ),
    Recipe(
      id: '1',
      title: 'Panna cotta met tartaar van kiwi en kokoscrumble',
      description:
      'Zó eenvoudig, maar ook zó lekker: panna cotta is een klassieker als nagerecht. Je hebt er niet veel werk aan, maar hou er rekening mee dat dit dessert minstens 2 uur nodig heeft om op te stijven. Dat geeft jou wel voldoende tijd om nog een heerlijke tartaar van kiwi en een kokoscrumble te maken.',
      type: RecipeType.mains,
      isVegetarian: false,
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
      stepImages: [
        'https://images.vrt.be/dako2017_1600s_j75/2019/03/01/4289ca34-3bfa-11e9-abcc-02b7b76bf47f.jpg',
        'https://images.vrt.be/dako2017_1600s_j75/2019/03/01/4289ca34-3bfa-11e9-abcc-02b7b76bf47f.jpg',
      ],
      rating: 3.5,
      duration: 55,
      image:
      'https://images.vrt.be/dako2017_1600s_j75/2019/03/01/4289ca34-3bfa-11e9-abcc-02b7b76bf47f.jpg',
      numberOfReviews: 0,
      userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.amateur.index},
    ),
    Recipe(
      id: '2',
      title: 'Cannelloni met gerookte zalm, asperges en spinazie',
      description:
      'Een cannelloni met het klassieke trio: zalm, spinazie en ricotta. Het pastagerecht past helemaal binnen dit seizoen dankzij de verrukkelijke asperges. Een toppertje dat gegarandeerd met open armen zal worden ontvangen thuis! ',
      type: RecipeType.mains,
      isVegetarian: false,
      ingredients: [
        'asperge',
        'zout',
        'gerookte zalm',
      ],
      stepDescriptions: [
        'Verwarm de oven voor op 180°C.',
        'Zet een pot gezouten water op het vuur en doe er meteen de asperges in. Breng de asperges aan de kook.'
      ],
      stepImages: [
        'https://images.vrt.be/dako2017_1600s_j75/2020/06/04/b108f8fd-a66e-11ea-aae0-02b7b76bf47f.jpg',
        'https://images.vrt.be/dako2017_1600s_j75/2020/06/04/b108f8fd-a66e-11ea-aae0-02b7b76bf47f.jpg',
      ],
      rating: 4.9,
      duration: 125,
      image:
      'https://images.vrt.be/dako2017_1600s_j75/2020/06/04/b108f8fd-a66e-11ea-aae0-02b7b76bf47f.jpg',
      numberOfReviews: 0,
      userMap: {'id' : 'id', 'name' : 'Jeroen Meus', 'Rank' : RankType.amateur.index},
    ),
    Recipe(
      id: '3',
      title: 'Secreto met gegrilde abrikozen en gebakken aardappelen',
      description:
      'Jeroen kookt vanop de Plaza Ochavada in het zonovergoten Archidona, waar hij aan de slag gaat met secreto. Dit prachtig stukje varkensvlees is doorspekt met vet en heeft daardoor ontzettend veel smaak. Serveer met gebakken aardappelen en een simpele fruitsalade.',
      type: RecipeType.mains,
      isVegetarian: false,
      ingredients: [
        'aardappelen',
        'olijfolie',
        'knoflook',
      ],
      stepDescriptions: [
        'Verwarm de barbecue.',
        'Kook de aardappelen in de pel gaar in een pot gezouten water.'
      ],
      stepImages: [
        'https://images.vrt.be/dako2017_1600s_j75/2018/07/26/a551d429-90df-11e8-abcc-02b7b76bf47f.jpg',
        'https://images.vrt.be/dako2017_1600s_j75/2018/07/26/a551d429-90df-11e8-abcc-02b7b76bf47f.jpg',
      ],
      rating: 2.5,
      duration: 25,
      image:
      'https://images.vrt.be/dako2017_1600s_j75/2018/07/26/a551d429-90df-11e8-abcc-02b7b76bf47f.jpg',
      numberOfReviews: 0,
      userMap: {'id' : 'id', 'name' : 'Michiel Proost', 'Rank' : RankType.beginner.index},
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
      favourites: ['0', '1'],
    ),
    User(
      id: '3',
      name: 'Dieter',
      score: 500,
      rank: RankType.beginner,
      favourites: ['2'],
    ),
  ];
}