# Cookbook

Cookbook is an Android application built with Flutter that allows users to search for and receive recommendations for food recipes using the Spoonacular API.

## Features

- **Search Recipes**: Users can search for recipes by entering keywords or ingredients.
- **Recipe Recommendations**: The app provides personalized recipe recommendations based on user preferences.
- **Detailed Recipe Information**: Each recipe includes detailed information such as ingredients, instructions, nutritional information, and cooking time.
- **Save Favorite Recipes**: Users can save their favorite recipes for quick access later.
- **Shopping List**: Users can add ingredients from recipes to a shopping list.

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/CrayFish0/cookbook.git
    cd cookbook
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Set up the Spoonacular API key:**

    - Obtain an API key from [Spoonacular](https://spoonacular.com/food-api).
    - In the [Secrets](lib/util/secrets.dart) folder add your api key:

        ```env
        const spoonacularApi = 'YOUR_API_KEY_HERE';
        ```

4. **Run the app:**

    ```bash
    flutter run
    ```

## Usage

1. **Search for Recipes:**

    - Enter keywords or ingredients in the search bar to find recipes.

2. **View Recipe Details:**

    - Tap on a recipe to view detailed information including ingredients, instructions, and summary.

3. **Save Favorite Recipes:**

    - Tap the plus icon on a recipe to save it to your favorites.

4. **Recommended recipes every day:**

    - Shows recommended recipies on the top of the page every day

## Dependencies

- [Flutter](https://flutter.dev)
- [Spoonacular API](https://spoonacular.com/food-api)
- [http](https://pub.dev/packages/http)
- [provider](https://pub.dev/packages/provider)

## Acknowledgements

We would like to thank the following resources and communities for their invaluable contributions:

- [Spoonacular](https://spoonacular.com/food-api) for providing an extensive food and recipe API.
- The [Flutter](https://flutter.dev) community for their continuous support and contributions.
- [Pub.dev](https://pub.dev) for hosting and maintaining a plethora of Flutter packages.
- All the contributors who helped improve this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or concerns, please open an issue or contact us at [cray.fish.75.02@gmail.com].

---

Happy cooking with Cookbook!
