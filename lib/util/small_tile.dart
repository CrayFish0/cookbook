import 'dart:developer';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class SmallTile extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  const SmallTile(
      {super.key, required this.id, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {log('message')},
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(177, 255, 199, 1),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(102, 180, 124, 1), blurRadius: 4)
            ]),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(color: Colors.white,
                  child: Image.network(
                    image,
                    opacity: const AlwaysStoppedAnimation(.8),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FavoriteButton(
                    iconSize: 30,
                    iconColor: const Color.fromARGB(255, 255, 70, 46),
                    iconDisabledColor: const Color.fromRGBO(102, 180, 124, 1),
                    valueChanged: (isFavourite) {
                      log('message');
                    },
                  )),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 8, right: 28),
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
