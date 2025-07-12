import 'package:cookbook/model/favourite.dart';
import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/theme/theme.dart';
import 'package:cookbook/util/background_widget.dart';
import 'package:cookbook/util/favourite_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Defer the call to after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      readFavs();
    });
  }

  void readFavs() {
    context.read<FavouriteDatabase>().fetchFavourites();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final favouriteDatabase = context.watch<FavouriteDatabase>();
    List<Favourite> currentFavourite = favouriteDatabase.currentFavourite;

    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Favorites',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${currentFavourite.length} saved recipes',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Provider.of<FavouriteDatabase>(context, listen: false)
                              .toggleTheme();
                        },
                        icon: Icon(
                          Provider.of<FavouriteDatabase>(context).themeData ==
                                  darkmode
                              ? Icons.light_mode_outlined
                              : Icons.dark_mode_outlined,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Favorites List
              Expanded(
                child: currentFavourite.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              size: 64,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No favorites yet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start saving your favorite recipes!',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        itemCount: currentFavourite.length,
                        itemBuilder: (context, index) {
                          final fav = currentFavourite[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FavouriteTile(
                              id: fav.newId,
                              image: fav.image,
                              name: fav.name,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
