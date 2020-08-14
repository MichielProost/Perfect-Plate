# Perfect Plate
The application acts as a database for user-made recipes. Cheffs around the world can make, share and review recipes. Additionally, we want to make the learning process for beginners more fun!

## Specifications

### Version 1.1
1.  The application acts as a database for user-made recipes
2.  Every user can (not mandatory) make an account
3.  With an account, the user can create his own recipe
4.  A recipe can be published for other users to access (default = private)
5.  As soon as you open the application, the user will receive recommendations based on previously created or searched for recipes
6.  A user can search for specific recipes in the database based on his available ingredients
7.  The user will receive points when:
    - Creating a recipe
    - Other users access one of his recipes
    - Other users give his recipe a good review
8.  These points give the user a rank (rookie à professional chef). This rank shows up on your own recipes or when reviewing other     recipes
9. A recipe contains:
    - The ingredients. Every ingredient has a slider to specify an amount
    - The steps; how to make the recipe
    - Pictures of the end dish or intermediary steps (not mandatory)
10. Other users can rate a recipe with an amount of stars. The review weighs more when given by users with a higher rank
11. Recipes can be shared among users
12. A user can favourite a recipe (add it to his list)
13. Every recipe holds the amount of times it has been accessed or viewed
14. A user can mark any recipe as _made_ or not _made_

### Version 1.2

#### Concept

The application acts as a database for user-made recipes.

#### Account?

1.  User **doesn’t** have an account
    -   The user can scroll through all the recipes in the database. 
    -   Every recipe is summarized with its title, score and picture.
2.  User **has** an account. The user has access to a lot more features:
    -   He can create his own recipe (public or private) 
    -   Personalised recommendations on homepage (e.g. machine learning), based on previously created or searched for recipes
    -   He can view his previously made recipes with their score, amount of ingredients and issued steps
    -   He can share recipes to other users through Social Media
    -   He can search for specific recipes in the database based on his available ingredients
    -   He can view details of his account including his rank (number of points), name and favourite recipes

#### Recipe

A user-made recipe contains the following data:
-   A title that summarizes the dish (mandatory)
-   A description that describes the dish in more detail (not mandatory)
-   The amount of ingredients
-   The steps on how to make the dish (at least five steps)
-   Photos of the steps (not mandatory)
-   A photo of the result (mandatory)

Additional data:

-   The recipe is public (other users can see the recipe) or private (other user can’t see the recipe)
-   Information of the creator (his username and rank)
-   The recipe’s score
-   Reviews from other users
-   The amount of times the recipe has been accessed or viewed

#### Search

A user with an account can use the **search** option. He can search for specific recipes in the database based on the ingredients, name or creator of the recipe. The screen will be very similar to that in figure 1. The only difference is that the shown recipes will be based on the search options, rather than the recommended dishes.

#### Score system

Every user has a rank based on his total score.
A new user will start with the lowest rank (e.g. rookie). He will be promoted to a higher rank once his score reaches a certain amount.
A user will receive points in the following events:
-   When creating a recipe
-   When other users view his recipe. The viewer has to be unique.
-   When other users give his recipe a review (a better review corresponds to more points)
-   When reviewing another user
The rank of the user shows up on his recipes or when reviewing other recipes.
