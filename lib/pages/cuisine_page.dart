import 'package:cookbook/util/global.dart';
import 'package:cookbook/util/main_cuisine_tile.dart';
import 'package:cookbook/util/secrets.dart';
import 'package:cookbook/util/small_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CuisinePage extends StatefulWidget {
  final String currentName;
  const CuisinePage({super.key, required this.currentName});

  @override
  State<CuisinePage> createState() => _CuisinePageState();
}

class _CuisinePageState extends State<CuisinePage> {
  late Future<Map<String, dynamic>> recipes;
  @override
  void initState() {
    newCuisine = widget.currentName;
    recipes = getRecipes(newCuisine);
    super.initState();
  }

  Future<Map<String, dynamic>> getRecipes(String? search) async {
    String? newSearch = search == 'All' ? '' : search;
    try {
      String link =
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularApi&cuisine=$newSearch';
      final res = await http.get(
        Uri.parse(link),
      );
      final data = jsonDecode(res.body);
      if (data['totalResults'] == 0) {
        throw 'No result Found';
      }
      return data;
    } catch (e) {
      throw 'Connection Error';
    }
  }

  callback(newname) {
    setState(() {
      newCuisine = newname;
      recipes = getRecipes(newCuisine);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        'Cusines',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Ariel',
                            color: Theme.of(context).colorScheme.primaryFixed),
                      ),
                    )),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 30),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
            child: CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: [
                SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return MainCuisineTile(
                          cuisineName: cuisineItems[index],
                          currentColor: cuisineItems[index] == newCuisine
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.primaryContainer,
                          callback: callback);
                    }, childCount: cuisineItems.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 0.6))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.77,
              child: FutureBuilder(
                  future: recipes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    final resultdata = snapshot.data!;
                    final result = resultdata['results'];
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: CustomScrollView(
                            scrollDirection: Axis.vertical,
                            slivers: [
                              SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    final resultId = result[index]['id'];
                                    final name = result[index]['title'];
                                    final image =
                                        result[index]['image'] ?? 'No Image';

                                    return SmallTile(
                                        id: resultId, image: image, name: name);
                                  },
                                      childCount:
                                          resultdata['totalResults'] < 10
                                              ? resultdata['totalResults']
                                              : 10),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 16,
                                          crossAxisSpacing: 16,
                                          childAspectRatio: 1))
                            ],
                          )),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}

//