import 'package:cookbook/model/favourite.dart';
import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/util/favourite_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();

    readFavs();
  }

  void readFavs() {
    context.read<FavouriteDatabase>().fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    final favouriteDatabase = context.watch<FavouriteDatabase>();
    List<Favourite> currentFavourite = favouriteDatabase.currentFavourite;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          //Logo initialisation
          title: Image.asset(
            "assets/Logo.png",
            width: 120,
            height: 120,
          ),
          //curved edges
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          )),
          //colour initialization
          backgroundColor: const Color.fromRGBO(177, 255, 199, 1),
          shadowColor: const Color.fromRGBO(102, 180, 124, 1),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'FAVOURITES',
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Ariel',
                    color: Color.fromRGBO(0, 70, 20, 1)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.7,
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final fav = currentFavourite[index];
                          return FavouriteTile(
                            id: fav.newId,
                            image: fav.image,
                            name: fav.name,realId: fav.id,
                          );
                        }, childCount: currentFavourite.length),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 3))
                  ],
                )),
          ],
        ));
  }
}