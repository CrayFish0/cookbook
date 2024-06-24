// ignore_for_file: prefer_const_constructors

import 'dart:convert';
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
            'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularApi'),
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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          )),
          //colour initialization
          backgroundColor: Color.fromRGBO(177, 255, 199, 1),
          shadowColor: Color.fromRGBO(102, 180, 124, 1),
        ),
        body: FutureBuilder(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final data = snapshot.data!;
              return Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('TODAYS TOP PICKS',style: TextStyle(fontSize: 24,fontFamily: 'Ariel'),),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height/2.55,
                            child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final result = data['results'];
                                  final resultId = result[index]['id'];
                                  final name = data['results'][index]['title'];
                                  final image = data['results'][index]['image'];
                                  return SearchTile(
                                    id: resultId,
                                    image: image,
                                    title: name,
                                  );
                                }))
                      ]));
            }));
  }
}
/*
FutureBuilder(
            future: recipes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              final data = snapshot.data!;
              return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final result = data['results'];
                    final resultId = result[index]['id'];
                    final name = data['results'][index]['title'];
                    final image = data['results'][index]['image'];
                    return SearchTile(
                      id: resultId,
                      image: image,
                      title: name,
                    );
                  });
            })
*/