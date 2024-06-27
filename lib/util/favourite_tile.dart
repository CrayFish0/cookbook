import 'dart:developer';
import 'package:flutter/material.dart';

class FavouriteTile extends StatelessWidget {
  final int id;
  final String image;
  final String name;
  const FavouriteTile(
      {super.key, required this.id, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('message');
      },
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color.fromRGBO(177, 255, 199, 1),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Color.fromRGBO(102, 180, 124, 1), blurRadius: 4)
            ]),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        image,
                        opacity: const AlwaysStoppedAnimation(0.8),
                      )),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 24,
                      top: 20,
                      right: 8),
                  child: Text(
                    name,
                    style: const TextStyle(fontFamily: 'Ariel'),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {
                      log('message');
                    },
                    icon: Icon(Icons.delete)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
