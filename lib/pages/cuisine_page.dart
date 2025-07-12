import 'package:cookbook/util/background_widget.dart';
import 'package:cookbook/util/global.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    newCuisine = widget.currentName;
    recipes = getRecipes(newCuisine);
    super.initState();
  }

  Future<Map<String, dynamic>> getRecipes(String? search) async {
    String? newSearch = search == 'All' ? '' : search;
    try {
      setState(() {
        _isLoading = true;
      });

      String link =
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularApi&cuisine=$newSearch&number=20';
      final res = await http.get(Uri.parse(link));
      final data = jsonDecode(res.body);

      if (data['totalResults'] == 0) {
        throw 'No recipes found for this cuisine';
      }
      return data;
    } catch (e) {
      throw 'Connection error. Please try again.';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void callback(String newname) {
    setState(() {
      newCuisine = newname;
      recipes = getRecipes(newCuisine);
    });
  }

  // Get emoji for cuisine
  String getCuisineEmoji(String cuisine) {
    switch (cuisine.toLowerCase()) {
      case 'italian':
        return '🍝';
      case 'chinese':
        return '🥢';
      case 'japanese':
        return '🍣';
      case 'indian':
        return '🍛';
      case 'mexican':
        return '🌮';
      case 'french':
        return '🥐';
      case 'thai':
        return '🍜';
      case 'american':
        return '🍔';
      case 'mediterranean':
        return '🫒';
      case 'korean':
        return '🥘';
      case 'german':
        return '🥨';
      case 'spanish':
        return '🥘';
      case 'greek':
        return '🫐';
      case 'vietnamese':
        return '🍲';
      case 'caribbean':
        return '🥥';
      case 'african':
        return '🌶️';
      case 'middle eastern':
        return '🧆';
      case 'british':
        return '🍻';
      case 'southern':
        return '🍗';
      case 'cajun':
        return '🦐';
      default:
        return '🍽️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuisines',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          Text(
                            'Explore $newCuisine recipes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Cuisine Filter Pills
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: cuisineItems.length,
                  itemBuilder: (context, index) {
                    final cuisine = cuisineItems[index];
                    final isSelected = cuisine == newCuisine;

                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () => callback(cuisine),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .tertiaryFixedDim,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                getCuisineEmoji(cuisine),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cuisine,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Results Section
              Expanded(
                child: FutureBuilder(
                  future: recipes,
                  builder: (context, snapshot) {
                    if (_isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              snapshot.error.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const SizedBox();
                    }

                    final resultdata = snapshot.data!;
                    final result = resultdata['results'];

                    if (result.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              getCuisineEmoji(newCuisine ?? 'All'),
                              style: const TextStyle(fontSize: 64),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No recipes found',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Try selecting a different cuisine',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          final resultId = result[index]['id'];
                          final name = result[index]['title'];
                          final image = result[index]['image'] ?? '';

                          return SmallTile(
                            id: resultId,
                            image: image,
                            name: name,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//