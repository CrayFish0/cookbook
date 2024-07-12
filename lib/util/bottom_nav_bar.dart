import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class BottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  BottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 90),
      child: GNav(
          backgroundColor: Theme.of(context).colorScheme.surface,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          activeColor: Theme.of(context).colorScheme.primaryFixedDim,
          color: Theme.of(context).colorScheme.primaryFixed,
          tabBackgroundColor: Theme.of(context).colorScheme.tertiaryFixedDim,
          tabActiveBorder:
              Border.all(color: Theme.of(context).colorScheme.tertiaryFixedDim),
          tabBorderRadius: 16,
          onTabChange: (value) => onTabChange!(value),
          tabs: [
            GButton(
              icon: Icons.home_rounded,
              text: 'Home',
              textColor: Theme.of(context).colorScheme.primaryFixedDim,
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
              textColor: Theme.of(context).colorScheme.primaryFixedDim,
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favs',
              textColor: Theme.of(context).colorScheme.primaryFixedDim,
            )
          ]),
    );
  }
}
