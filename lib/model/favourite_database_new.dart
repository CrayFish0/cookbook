import 'package:cookbook/model/favourite.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cookbook/theme/theme.dart';

class FavouriteDatabase extends ChangeNotifier {
  static late Box<Favourite> _favoritesBox;

  //Initialise
  static Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FavouriteAdapter());
    _favoritesBox = await Hive.openBox<Favourite>('favorites');
  }

  final List<Favourite> currentFavourite = [];

  //Create
  Future<void> addFavourite(String name, String image, int recipeId) async {
    // Check if already exists in current list
    final existingFav =
        currentFavourite.where((fav) => fav.newId == recipeId).firstOrNull;

    if (existingFav != null) {
      // Already exists, don't add duplicate
      return;
    }

    final newFavourite = Favourite()
      ..newId = recipeId
      ..name = name
      ..image = image;

    // Add to Hive box
    await _favoritesBox.add(newFavourite);

    // Add to memory
    currentFavourite.add(newFavourite);
    notifyListeners();
  }

  //Check if item is favorite
  bool isFavourite(int recipeId) {
    return currentFavourite.where((fav) => fav.newId == recipeId).isNotEmpty;
  }

  //Remove from favorites by recipeId
  Future<void> removeFavouriteByRecipeId(int recipeId) async {
    final existingFav =
        currentFavourite.where((fav) => fav.newId == recipeId).firstOrNull;

    if (existingFav != null) {
      // Remove from Hive box
      await existingFav.delete();

      // Remove from memory
      currentFavourite.remove(existingFav);
      notifyListeners();
    }
  }

  //Read
  Future<void> fetchFavourites() async {
    final fetchedFavourites = _favoritesBox.values.toList();
    currentFavourite.clear();
    currentFavourite.addAll(fetchedFavourites);
    notifyListeners();
  }

  //Update
  Future<void> updateFavourite(int id, String name, String image) async {
    final existingFavourite = _favoritesBox.get(id);

    if (existingFavourite != null) {
      existingFavourite.name = name;
      existingFavourite.image = image;
      await existingFavourite.save();
      await fetchFavourites();
    }
  }

  //Delete
  Future<void> deleteFavourite(int id) async {
    await _favoritesBox.delete(id);
    await fetchFavourites();
  }

  // Theme data
  ThemeData _themeData = darkmode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == darkmode) {
      themeData = lightmode;
    } else {
      themeData = darkmode;
    }
  }
}
