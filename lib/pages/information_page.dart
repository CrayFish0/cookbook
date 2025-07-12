import 'dart:convert';
import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/util/background_widget.dart';
import 'package:cookbook/util/secrets.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class InformationPage extends StatefulWidget {
  final String name;
  final int id;
  final String image;
  const InformationPage({
    super.key,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  Map<String, dynamic>? data;
  late Future<Map<String, dynamic>> recipes;
  bool _isLiked = false;

  @override
  void initState() {
    recipes = getRecipes();
    // Defer the call to after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfFavorited();
    });
    super.initState();
  }

  void _checkIfFavorited() {
    final favouriteDatabase = context.read<FavouriteDatabase>();
    setState(() {
      _isLiked = favouriteDatabase.isFavourite(widget.id);
    });
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
        throw 'No result found';
      }
      return data;
    } catch (e) {
      throw 'Connection error. Please try again.';
    }
  }

  void _toggleFavorite() {
    final favouriteDatabase = context.read<FavouriteDatabase>();

    if (_isLiked) {
      // Remove from favorites
      favouriteDatabase.removeFavouriteByRecipeId(widget.id);
      setState(() {
        _isLiked = false;
      });
      Fluttertoast.showToast(
        msg: 'Removed from favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        textColor: Theme.of(context).colorScheme.surface,
      );
    } else {
      // Add to favorites
      favouriteDatabase.addFavourite(widget.name, widget.image, widget.id);
      setState(() {
        _isLiked = true;
      });
      Fluttertoast.showToast(
        msg: 'Added to favorites',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.primary,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: CustomScrollView(
          slivers: [
            // App Bar with Image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.tertiary,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: _isLiked ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.restaurant_menu,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: recipes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
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
                      ),
                    );
                  }

                  data = snapshot.data!;
                  final summary =
                      Bidi.stripHtmlIfNeeded(data?['summary'] ?? '');
                  final ingredients = data?['extendedIngredients'] ?? [];
                  final instructions =
                      Bidi.stripHtmlIfNeeded(data?['instructions'] ?? '');
                  final analyzedInstructions =
                      (data?['analyzedInstructions'] as List?)?.isNotEmpty ==
                              true
                          ? (data?['analyzedInstructions'][0]['steps']
                                  as List?) ??
                              []
                          : <dynamic>[];
                  final readyInMinutes = data?['readyInMinutes'] ?? 0;
                  final servings = data?['servings'] ?? 0;

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Info
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Recipe Info Row
                        Row(
                          children: [
                            _InfoChip(
                              icon: Icons.access_time,
                              label: '$readyInMinutes min',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            _InfoChip(
                              icon: Icons.people,
                              label: '$servings servings',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            _InfoChip(
                              icon: Icons.star,
                              label: '4.5',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Ingredients Section
                        if (ingredients.isNotEmpty) ...[
                          _SectionTitle('Ingredients'),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ingredients.length,
                              itemBuilder: (context, index) {
                                final ingredient = ingredients[index];
                                return Container(
                                  width: 120,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiaryFixedDim,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            ingredient['name']
                                                    ?.toString()
                                                    .toUpperCase() ??
                                                '',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiary,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          '${ingredient['measures']?['metric']?['amount']?.toStringAsFixed(1) ?? ''} ${ingredient['measures']?['metric']?['unitShort'] ?? ''}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryFixed,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],

                        // Instructions Section
                        if (instructions.isNotEmpty) ...[
                          _SectionTitle('Instructions'),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryFixedDim,
                              ),
                            ),
                            child: ExpandableText(
                              instructions,
                              textAlign: TextAlign.justify,
                              expandText: 'Read more',
                              collapseText: 'Show less',
                              maxLines: 6,
                              linkColor: Theme.of(context).colorScheme.primary,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],

                        // Step by Step Instructions
                        if (analyzedInstructions.isNotEmpty) ...[
                          _SectionTitle('Step by Step'),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: analyzedInstructions.length,
                            itemBuilder: (context, index) {
                              final step = analyzedInstructions[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryFixedDim,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${step['number']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        step['step'] ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 32),
                        ],

                        // Summary Section
                        if (summary.isNotEmpty) ...[
                          _SectionTitle('About This Recipe'),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryFixedDim,
                              ),
                            ),
                            child: ExpandableText(
                              summary,
                              textAlign: TextAlign.justify,
                              expandText: 'Read more',
                              collapseText: 'Show less',
                              maxLines: 4,
                              linkColor: Theme.of(context).colorScheme.primary,
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _SectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
