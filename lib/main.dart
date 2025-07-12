import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavouriteDatabase.initialize();

  runApp(ChangeNotifierProvider(
    create: (context) => FavouriteDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).colorScheme.surface == Colors.white
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<FavouriteDatabase>(context).themeData,
      home: const MainPage(),
    );
  }
}
