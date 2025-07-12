import 'package:cookbook/util/background_widget.dart';
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

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  late Future<Map<String, dynamic>> recipes;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    recipes = getRecipes('');
    super.initState();
  }

  Future<Map<String, dynamic>> getRecipes(String? search) async {
    if (search == null || search.isEmpty) {
      return {'results': [], 'totalResults': 0};
    }

    try {
      setState(() {
        _isSearching = true;
      });

      String link =
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=$spoonacularApi&query=$search&number=20';
      final res = await http.get(Uri.parse(link));
      final data = jsonDecode(res.body);

      if (data['totalResults'] == 0) {
        throw 'No recipes found';
      }
      return data;
    } catch (e) {
      throw 'Connection error. Please try again.';
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Recipes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.tertiaryFixedDim,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              recipes = getRecipes(value);
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Search for recipes...',
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      recipes = getRecipes('');
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Results
              Expanded(
                child: FutureBuilder(
                  future: recipes,
                  builder: (context, snapshot) {
                    if (_isSearching) {
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 64,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Search for delicious recipes',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    final resultdata = snapshot.data!;
                    final result = resultdata['results'];

                    if (result.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.restaurant_menu,
                              size: 64,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No recipes found',
                              style: TextStyle(
                                fontSize: 16,
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
