import 'package:cookbook/model/favourite.dart';
import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/theme/theme.dart';
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
          title: Image.asset("assets/Logo.png",
              width: 120,
              height: 120,
              color: Theme.of(context).colorScheme.primaryFixed),
          //curved edges
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          )),

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                  onPressed: () {
                    Provider.of<FavouriteDatabase>(context, listen: false)
                        .toggleTheme();
                  },
                  icon: Icon(
                    Provider.of<FavouriteDatabase>(context).themeData ==
                            lightmode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  )),
            )
          ],
          //colour initialization
          backgroundColor: Theme.of(context).colorScheme.primary,
          shadowColor: Theme.of(context).colorScheme.secondary,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'FAVOURITES',
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Ariel',
                    color: Theme.of(context).colorScheme.tertiary),
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
                            name: fav.name,
                            realId: fav.id,
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
