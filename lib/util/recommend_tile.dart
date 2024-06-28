import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/information_page.dart';
import 'package:flutter/material.dart';
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
  void createFavourite() {
    context
        .read<FavouriteDatabase>()
        .addFavourite(widget.title, widget.image, widget.id);
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
                      )));
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
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image.network(
                          widget.image,
                          opacity: const AlwaysStoppedAnimation(.85),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              createFavourite();
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                            ))),
                  ),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 12, left: 12, right: 40),
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Ariel',
                              fontSize: 20,
                              color: Colors.grey.shade800),
                        ),
                      ))
                ],
              ),
            )));
  }
}
