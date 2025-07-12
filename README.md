# Cookbook

Cookbook is a modern Android application built with Flutter that allows users to search for and receive recommendations for food recipes using the Spoonacular API. The app features a beautiful, minimal design with dark mode by default and a sophisticated glassmorphism UI.

## ✨ Features

### Core Features

- **Search Recipes**: Users can search for recipes by entering keywords or ingredients with persistent search state
- **Recipe Recommendations**: Daily personalized recipe recommendations based on user preferences
- **Detailed Recipe Information**: Each recipe includes detailed information such as ingredients, instructions, nutritional information, and cooking time
- **Save Favorite Recipes**: Users can save their favorite recipes for quick access later with local storage
- **Cuisine Categories**: Browse recipes by cuisine type with interactive filter pills
- **Theme Toggle**: Switch between light and dark modes with a beautiful theme system

### UI/UX Improvements

- **Modern Design**: Complete UI overhaul with minimal, unique aesthetic
- **Dark Mode Default**: Beautiful dark theme with light mode option
- **Glassmorphism Background**: Sophisticated background with gradients, patterns, and floating animations
- **Floating Navigation**: Minimal pill-style bottom navigation with backdrop blur effects
- **State Persistence**: Search state and navigation state preserved across page switches
- **Responsive Layout**: Optimized layouts for different screen sizes
- **Visual Feedback**: Toast notifications and loading states for better user experience

### Performance & Architecture

- **Hive Database**: Fast, local NoSQL database for storing favorites
- **Provider State Management**: Efficient state management across the app
- **Optimized Navigation**: IndexedStack with AutomaticKeepAliveClientMixin for smooth transitions
- **Error Handling**: Comprehensive error handling with user-friendly messages

## 🚀 Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/CrayFish0/cookbook.git
    cd cookbook
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Generate Hive adapters:**

    ```bash
    flutter packages pub run build_runner build --delete-conflicting-outputs
    ```

4. **Set up the Spoonacular API key:**

    - Obtain an API key from [Spoonacular](https://spoonacular.com/food-api).
    - In the [Secrets](lib/util/secrets.dart) folder add your api key:

        ```dart
        const spoonacularApi = 'YOUR_API_KEY_HERE';
        ```

5. **Run the app:**

    ```bash
    flutter run
    ```

## 📱 Usage

1. **Search for Recipes:**

    - Enter keywords or ingredients in the search bar to find recipes
    - Search state persists when navigating between pages

2. **Browse by Cuisine:**

    - Explore different cuisine categories from the home page
    - Use filter pills to refine your search by cuisine type

3. **View Recipe Details:**

    - Tap on a recipe to view detailed information including ingredients, instructions, and summary
    - See nutritional information and cooking time

4. **Save Favorite Recipes:**

    - Tap the plus icon on a recipe to save it to your favorites
    - Access saved recipes from the favorites page
    - Remove favorites by tapping the delete icon

5. **Customize Your Experience:**

    - Toggle between light and dark mode using the theme button
    - Enjoy the beautiful glassmorphism background and animations

6. **Daily Recommendations:**

    - Discover new recipes with daily personalized recommendations on the home page

## 🛠️ Dependencies

### Core Dependencies

- [Flutter](https://flutter.dev) - UI framework
- [Spoonacular API](https://spoonacular.com/food-api) - Recipe data source
- [http](https://pub.dev/packages/http) - HTTP client for API calls
- [provider](https://pub.dev/packages/provider) - State management

### UI/UX Dependencies

- [google_nav_bar](https://pub.dev/packages/google_nav_bar) - Modern bottom navigation
- [fluttertoast](https://pub.dev/packages/fluttertoast) - Toast notifications
- [expandable_text](https://pub.dev/packages/expandable_text) - Expandable text widgets

### Data Storage

- [hive](https://pub.dev/packages/hive) - Fast, local NoSQL database
- [hive_flutter](https://pub.dev/packages/hive_flutter) - Hive Flutter integration
- [path_provider](https://pub.dev/packages/path_provider) - File system access

### Development Tools

- [build_runner](https://pub.dev/packages/build_runner) - Code generation
- [hive_generator](https://pub.dev/packages/hive_generator) - Hive adapter generation
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - App icon generation

## 🎨 Design System

The app features a modern design system with:

- **Color Scheme**: Carefully crafted color palette for both light and dark modes
- **Typography**: Custom font family (Arial) with consistent text styles
- **Glassmorphism**: Sophisticated background with blur effects and gradients
- **Animations**: Smooth transitions and floating shape animations
- **Responsive Design**: Adaptive layouts for different screen sizes

## 📂 Project Structure

```text
lib/
├── main.dart                 # App entry point
├── model/                    # Data models
│   ├── favourite.dart        # Favorite recipe model
│   ├── favourite.g.dart      # Generated Hive adapter
│   └── favourite_database.dart # Database operations
├── pages/                    # App screens
│   ├── home_page.dart        # Home screen with recommendations
│   ├── search_page.dart      # Recipe search screen
│   ├── favourite_page.dart   # Saved favorites screen
│   ├── cuisine_page.dart     # Cuisine-specific recipes
│   ├── information_page.dart # Recipe details screen
│   └── main_page.dart        # Main navigation wrapper
├── theme/                    # Theme and styling
│   └── theme.dart           # Light/dark theme definitions
├── util/                     # Utility widgets and helpers
│   ├── background_widget.dart # Glassmorphism background
│   ├── bottom_nav_bar.dart   # Custom navigation bar
│   ├── favourite_tile.dart   # Favorite recipe tile
│   ├── small_tile.dart       # Recipe preview tile
│   ├── recommend_tile.dart   # Recommendation tile
│   └── ...                  # Other utility widgets
└── assets/                   # App resources
    ├── icon.png             # App icon
    └── Logo.png             # App logo
```

## 🚀 Technical Improvements

### Database Migration

- **Migrated from Isar to Hive**: Improved compatibility and build stability
- **Local Storage**: Efficient favorite recipe storage with automatic data persistence
- **Type Safety**: Generated type adapters for reliable data serialization

### State Management

- **Provider Pattern**: Clean separation of UI and business logic
- **State Persistence**: Navigation and search state preserved across app lifecycle
- **Automatic Keep Alive**: Optimized memory usage with selective widget retention

### Performance Optimizations

- **Lazy Loading**: Efficient image loading with error handling
- **Optimized Layouts**: Reduced widget rebuilds and improved scroll performance
- **Memory Management**: Proper disposal of resources and listeners

### Build System

- **Android Gradle Plugin**: Updated to version 7.3.0 for compatibility
- **Kotlin Integration**: Proper Kotlin support with version 1.8.22
- **Code Generation**: Automated adapter generation with build_runner

## 🤝 Acknowledgements

We would like to thank the following resources and communities for their invaluable contributions:

- [Spoonacular](https://spoonacular.com/food-api) for providing an extensive food and recipe API
- The [Flutter](https://flutter.dev) community for their continuous support and contributions
- [Pub.dev](https://pub.dev) for hosting and maintaining a plethora of Flutter packages
- The [Hive](https://pub.dev/packages/hive) team for creating a fast, local database solution
- All the contributors who helped improve this project

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

For any questions or concerns, please open an issue or contact us at [cray.fish.75.02@gmail.com].

---

## 🎉 What's New in v2.0

✨ **Complete UI/UX Overhaul**: Modern, minimal design with dark mode default  
🎨 **Glassmorphism Effects**: Beautiful background animations and blur effects  
🔍 **Enhanced Search**: Persistent search state and improved filtering  
💾 **Better Data Storage**: Migrated to Hive for improved performance  
🚀 **Performance Improvements**: Optimized navigation and state management  
🎯 **Better UX**: Toast notifications, loading states, and responsive design  

**Happy cooking with the new and improved Cookbook! 🍳**
