import 'dart:convert';
import 'package:cookbook/util/cuisine_tile.dart';
import 'package:cookbook/util/global.dart';
import 'package:cookbook/util/search_tile.dart';
import 'package:cookbook/util/secrets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> recipes;
  @override
  void initState() {
    recipes = getRecipes();
    super.initState();
  }

  Future<Map<String, dynamic>> getRecipes() async {
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.spoonacular.com/recipes/random?apiKey=$spoonacularApi&includeNutrition=false&number=10'),
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
    //List<List<String>> a = [];
    return Scaffold(
        body: Padding(
                  padding: const EdgeInsets.all(0),
                  child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'TODAYS TOP PICKS',
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Ariel',
                                color: Color.fromRGBO(0, 70, 20, 1)),
                          ),
                        ),const SizedBox(height: 5,)
                        ,
                        SizedBox(
                            height: (MediaQuery.of(context).size.width - 50),
                            child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final result = data?['recipes'];
                                  final resultId = result[index]['id'];
                                  final name = result[index]['title'];
                                  final image = result[index]['image'] ?? 'No Image';
                                  return SearchTile(
                                    id: resultId,
                                    image: image,
                                    title: name,
                                  );
                                })),
                        const SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'CUISINE',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Ariel',
                                color: Color.fromRGBO(0, 70, 20, 1)),
                          ),
                        ),
                        const SizedBox(height: 15,)
                        ,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SizedBox(
                              height: (MediaQuery.of(context).size.width/2.9),
                              child: CustomScrollView(
                                scrollDirection: Axis.horizontal,
                                slivers: [
                                  SliverGrid(
                                      delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                        return CuisineTile(cuisineName: cuisineItems[index]);
                                      },childCount: cuisineItems.length),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 16,crossAxisSpacing: 16,childAspectRatio: 0.41))
                                ],
                              )),
                        ),
                      ]))
            );
  }
}
//Text color 0 50 14
//'African','Asian','American','British','Cajun','Caribbean','Chinese','Eastern European','European','French','German','Greek','Indian','Irish','Italian','Japanese','Jewish','Korean','Latin American','Mediterranean','Mexican','Middle Eastern','Nordic','Southern','Spanish','Thai','Vietnamese'