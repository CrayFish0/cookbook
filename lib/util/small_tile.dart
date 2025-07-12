import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/information_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SmallTile extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  const SmallTile({
    super.key,
    required this.id,
    required this.image,
    required this.name,
  });

  @override
  State<SmallTile> createState() => _SmallTileState();
}

class _SmallTileState extends State<SmallTile> {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformationPage(
              id: widget.id,
              image: widget.image,
              name: widget.name,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiaryFixedDim,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Theme.of(context).colorScheme.tertiaryFixedDim,
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        widget.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color:
                                Theme.of(context).colorScheme.tertiaryFixedDim,
                            child: Icon(
                              Icons.restaurant_menu,
                              color: Theme.of(context).colorScheme.primaryFixed,
                              size: 32,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Like Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        toggleFavourite();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: _isLiked
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ), // Content
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Rating
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.primary,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
