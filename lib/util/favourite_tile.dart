import 'dart:developer';
import 'package:flutter/material.dart';

class FavouriteTile extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  const FavouriteTile({super.key,required this.id,required this.image,required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => {
      log('message')
    },
      child: Container(
        child: Stack(
          children: [
            Image.network(image),
          ],
        ),
      ),
    );
  }
}
