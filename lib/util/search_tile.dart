import 'dart:developer';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  const SearchTile({
    super.key,
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          log('$id $image $title');
          log((MediaQuery.of(context).size.width).toString());
        },
        child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 48),
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromRGBO(102, 180, 124, 1),
                      blurRadius: 7,
                      offset: Offset(0.0, 0.0))
                ],
                color: Color.fromRGBO(177, 255, 199, 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(30)),
                      child: Card(
                        elevation: 1,
                        child: Image.network(
                          image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 24,top: 13),
                          child: Text(
                            title,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Ariel', fontSize: 20),
                          ),
                        )),
                        Padding(
                            padding: const EdgeInsets.only(right: 12, top: 18),
                            child: FavoriteButton(
                              iconSize: 30,
                              iconColor: const Color.fromARGB(255, 255, 70, 46),
                              iconDisabledColor: Colors.black,
                              valueChanged: (isFavourite) {
                                log('message');
                              },
                            ))
                      ],
                    )
                  ]),
            ))
        );
  }
}