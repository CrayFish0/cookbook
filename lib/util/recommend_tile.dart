import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/information_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RecommendTile extends StatefulWidget {
  final int id;
  final String title;
  final String image;
  const RecommendTile({
    super.key,
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  State<RecommendTile> createState() => _RecommendTileState();
}

class _RecommendTileState extends State<RecommendTile> {
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    // Defer the call to after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkIfFavorited();
    });
  }

  void _checkIfFavorited() {
    final favouriteDatabase = context.read<FavouriteDatabase>();
    setState(() {
      _isLiked = favouriteDatabase.isFavourite(widget.id);
    });
  }

  void toggleFavourite() {
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
      favouriteDatabase.addFavourite(widget.title, widget.image, widget.id);
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformationPage(
              id: widget.id,
              image: widget.image,
              name: widget.title,
            ),
          ),
        );
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Container(
              height: 180,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Stack(
                children: [
                  // Recipe Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.image,
                      height: 180,
                      width: 220,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          width: 220,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: Icon(
                            Icons.restaurant_menu,
                            color: Theme.of(context).colorScheme.primary,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),

                  // Gradient Overlay
                  Container(
                    height: 180,
                    width: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
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

                  // Like Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        toggleFavourite();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: _isLiked
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Recipe Title
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Rating/Info Row
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '4.5',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.access_time,
                  color: Theme.of(context).colorScheme.primaryFixed,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '25 min',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primaryFixed,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
