import 'package:cookbook/pages/cuisine_page.dart';
import 'package:flutter/material.dart';

class CuisineTile extends StatelessWidget {
  final String cuisineName;
  const CuisineTile({super.key, required this.cuisineName});

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CuisinePage(currentName: cuisineName),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiaryFixedDim,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                getCuisineEmoji(cuisineName),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  cuisineName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
