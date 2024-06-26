// ignore_for_file: prefer_const_constructors

import 'package:cookbook/util/favourite_tile.dart';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
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
        body: ListView(
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
                height: MediaQuery.of(context).size.height,
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return FavouriteTile(
                            id: 715415,
                            image:
                                'https://img.spoonacular.com/recipes/715415-312x231.jpg',
                            name: 'Red Lentil Soup with Chicken and Turnips',
                          );
                        }, childCount: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 1))
                  ],
                )),
          ],
        ));
  }
}

/*id": 715415,
            "title": "Red Lentil Soup with Chicken and Turnips",
            "image": "https://img.spoonacular.com/recipes/715415-312x231.jpg",*/