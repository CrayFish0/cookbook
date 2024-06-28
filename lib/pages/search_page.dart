import 'package:cookbook/util/secrets.dart';
import 'package:cookbook/util/small_tile.dart';
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
      String link =
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularApi&query=$search';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onSubmitted: (value) => {
                    setState(() {
                      recipes = getRecipes(value);
                    })
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                    childCount: resultdata['totalResults'] < 10
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
          ],
        ));
  }
}
