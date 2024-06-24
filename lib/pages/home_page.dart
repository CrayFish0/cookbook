// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
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
            'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularapi'),
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
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(child: Padding(
            padding: EdgeInsets.all(24),
            child: Text('CookBook'),
          ),
        ),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          )
        ),
        backgroundColor: Color.fromRGBO(177, 255, 199, 1),
        shadowColor: Color.fromRGBO(102, 180, 124, 1),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
        child: Text('TODAYS TOP PICKS',style: TextStyle(fontSize: 24),),
      ),
    );
  }
}
