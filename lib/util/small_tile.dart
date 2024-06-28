import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/information_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallTile extends StatefulWidget {
  final int id;
  final String name;
  final String image;
  const SmallTile(
      {super.key, required this.id, required this.image, required this.name});

  @override
  State<SmallTile> createState() => _SmallTileState();
}

class _SmallTileState extends State<SmallTile> {
  void createFavourite() {
    context
        .read<FavouriteDatabase>()
        .addFavourite(widget.name, widget.image, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InformationPage(
                      id: widget.id,
                      image: widget.image,
                      name: widget.name,
                    )))
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
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  color: Colors.white,
                  child: Image.network(
                    widget.image,
                    opacity: const AlwaysStoppedAnimation(.8),
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
                      top: 8, bottom: 12, left: 8, right: 40),
                  child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
