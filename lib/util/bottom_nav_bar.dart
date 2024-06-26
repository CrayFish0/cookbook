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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GNav(
          mainAxisAlignment: MainAxisAlignment.center,
          activeColor: const Color.fromRGBO(102, 180, 124, 1),
          color: Colors.grey,
          iconSize: 28,
          tabBackgroundColor: const Color.fromARGB(255, 227, 227, 227),
          tabActiveBorder:
              Border.all(color: const Color.fromARGB(255, 201, 201, 201)),
          tabBorderRadius: 16,
          onTabChange: (value) => onTabChange!(value),
          tabs: const [
            GButton(
              icon: Icons.home_rounded,
              text: 'Home',
              textColor: Color.fromRGBO(102, 180, 124, 1),
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
              textColor: Color.fromRGBO(102, 180, 124, 1),
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favs',
              textColor: Color.fromRGBO(102, 180, 124, 1),
            )
          ]),
    );
  }
}
