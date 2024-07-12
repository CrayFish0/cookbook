import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/theme/theme.dart';
import 'package:cookbook/util/cuisine_tile.dart';
import 'package:cookbook/util/global.dart';
import 'package:cookbook/util/recommend_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //List<List<String>> a = [];
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Padding(
            padding: const EdgeInsets.all(0),
            child: ListView(children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'TODAYS TOP PICKS',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Ariel',
                      color: Theme.of(context).colorScheme.primaryFixed),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: (MediaQuery.of(context).size.width - 60),
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final result = data?['recipes'];
                        final resultId = result[index]['id'];
                        final name = result[index]['title'];
                        final image = result[index]['image'] ?? 'No Image';
                        return RecommendTile(
                          id: resultId,
                          image: image,
                          title: name,
                        );
                      })),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'CUISINE',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Ariel',
                      color: Theme.of(context).colorScheme.primaryFixed),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                    height: (MediaQuery.of(context).size.width / 2.9),
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      slivers: [
                        SliverGrid(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return CuisineTile(
                                  cuisineName: cuisineItems[index]);
                            }, childCount: cuisineItems.length),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    childAspectRatio: 0.41))
                      ],
                    )),
              ),
            ])));
  }
}
