// ignore_for_file: prefer_const_constructors

import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavouriteDatabase.initialize();

  runApp(ChangeNotifierProvider(
    create: (context) => FavouriteDatabase(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<FavouriteDatabase>(context).themeData,
      home: MainPage(),
    );
  }
}
