// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:cookbook/util/ingredients_tile.dart';
import 'package:cookbook/util/instructions_tile.dart';
import 'package:cookbook/util/secrets.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationPage extends StatefulWidget {
  final String name;
  final int id;
  final String image;
  const InformationPage(
      {super.key, required this.id, required this.image, required this.name});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  Map<String, dynamic>? data;
  late Future<Map<String, dynamic>> recipes;
  @override
  void initState() {
    recipes = getRecipes();
    super.initState();
  }

  Future<Map<String, dynamic>> getRecipes() async {
    final newId = widget.id;
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.spoonacular.com/recipes/$newId/information?apiKey=$spoonacularApi'),
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
        body: Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                color: Colors.black,
                child: Image.network(
                  widget.image,
                  opacity: AlwaysStoppedAnimation(0.8),
                ))),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_rounded)),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        blurRadius: 10, color: Color.fromRGBO(102, 180, 124, 1))
                  ],
                  color: Color.fromRGBO(177, 255, 199, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.width * (2 / 3)) +
                  20,
              child: FutureBuilder(
                  future: recipes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    data = snapshot.data!;
                    final summary = Bidi.stripHtmlIfNeeded(data?['summary']);
                    final ingredients = data?['extendedIngredients'];
                    final instructions =
                        Bidi.stripHtmlIfNeeded(data?['instructions']);
                    final analyzedInstructions =
                        data?['analyzedInstructions'][0]['steps'];
                    return ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            widget.name.toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'Ariel',
                                fontSize: 26,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                                fontFamily: 'Ariel',
                                fontSize: 25,
                                color: Colors.grey.shade700),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            color: Color.fromARGB(70, 255, 255, 255),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: ingredients.length,
                                itemBuilder: (context, index) {
                                  return IngredientsTile(
                                      amount: ingredients[index]['measures']
                                          ['metric']['amount'],
                                      measurement: ingredients[index]
                                              ['measures']['metric']['unitLong']
                                          .toString()
                                          .toUpperCase(),
                                      name: ingredients[index]['name']
                                          .toString()
                                          .toUpperCase());
                                })),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Instructions',
                            style: TextStyle(
                                fontFamily: 'Ariel',
                                fontSize: 23,
                                color: Colors.grey.shade700),
                          ),
                        ),
                        Container(
                          color: Color.fromARGB(70, 255, 255, 255),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(177, 255, 199, 1),
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                          blurRadius: 4,
                                          color:
                                              Color.fromRGBO(102, 180, 124, 1))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: ExpandableText(
                                    instructions,
                                    textAlign: TextAlign.justify,
                                    animationDuration: Durations.long1,
                                    animation: true,
                                    expandText: 'Show More',
                                    collapseText: 'Show Less',
                                    linkColor: Color.fromRGBO(102, 180, 124, 1),
                                    style: TextStyle(
                                        fontFamily: 'Ariel',
                                        fontSize: 16,
                                        color: Colors.grey.shade600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Detailed Instructions',
                            style: TextStyle(
                                fontFamily: 'Ariel',
                                fontSize: 20,
                                color: Colors.grey.shade600),
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            color: Color.fromARGB(70, 255, 255, 255),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: analyzedInstructions.length,
                                itemBuilder: (context, index) {
                                  return InstructionsTile(
                                      step: analyzedInstructions[index]['step'],
                                      stepNo: analyzedInstructions[index]
                                          ['number']);
                                })),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ExpandableText(
                              summary,
                              textAlign: TextAlign.justify,
                              animation: true,
                              expandText: 'Show More',
                              collapseText: 'Show Less',
                              linkColor: Color.fromRGBO(102, 180, 124, 1),
                              style: TextStyle(
                                  fontFamily: 'Ariel',
                                  fontSize: 16,
                                  color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
        )
      ],
    ));
  }
}
