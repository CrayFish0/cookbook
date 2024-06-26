import 'package:cookbook/util/favourite_tile.dart';
import 'package:cookbook/util/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<Map<String, dynamic>> recipes;
  @override
  void initState() {
    recipes = getRecipes('');
    super.initState();
  }

  Future<Map<String, dynamic>> getRecipes(String? search) async {
    try {
      String link = 'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularApi&query=$search';
      final res = await http.get(
        Uri.parse(link),
      );
      final data = jsonDecode(res.body);
      if (data['totalResults'] == 0) {
        throw 'No result Found';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(onSubmitted: (value) => {setState(() {
              recipes=getRecipes(value);
            })
            },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search...',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
        ),
        FutureBuilder(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final resultdata = snapshot.data!;
              return Container(
                  padding: const EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height,
                  child: CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: [
                      SliverGrid(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            final result = resultdata['results'];
                            final resultId = result[index]['id'];
                            final name = result[index]['title'];
                            final image = result[index]['image'] ?? 'No Image';
                            return Center(child: Text(name));
                          }, childCount: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 1))
                    ],
                  ));
            }),
      ],
    ));
  }
}
/* Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Center(child: Text('Placeholder Text'));
                    }, childCount: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 1))
              ],
            )),*/