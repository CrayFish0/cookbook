

import 'package:cookbook/model/favourite.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class FavouriteDatabase extends ChangeNotifier {
  static late Isar isar;

  //Initialise
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([FavouriteSchema], directory: dir.path);
  }

  final List<Favourite> currentFavourite = [];

  //Create
  Future<void> addFavourite(String name, String image, int recipeId) async {

    final newFavourite = Favourite()..newId = recipeId;

    newFavourite.newId = recipeId;
    newFavourite.image = image;
    newFavourite.name = name;

    await isar.writeTxn(() => isar.favourites.put(newFavourite));
    fetchFavourites();
  }

  //Read
  Future<void> fetchFavourites() async {
    List<Favourite> fetchFavourites = await isar.favourites.where().findAll();
    currentFavourite.clear();
    currentFavourite.addAll(fetchFavourites);
    notifyListeners();
  }

  //Update
  Future<void> updateFavourite(
      int id, String newname, String newimage, int newrecipeId) async {

    final existingFavourite = await isar.favourites.get(id);
    if (existingFavourite != null) {
      existingFavourite.image = newimage;
      existingFavourite.name = newimage;
      existingFavourite.newId = newrecipeId;
      await isar.writeTxn(() => isar.favourites.put(existingFavourite));
      await fetchFavourites();
    }
  }

  //Delete
  Future<void> deleteFavourite(int id) async {

    await isar.writeTxn(() => isar.favourites.delete(id));
    await fetchFavourites();
  }
}
