import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/information_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class FavouriteTile extends StatefulWidget {
  final Id realId;
  final int id;
  final String image;
  final String name;
  const FavouriteTile(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.realId});

  @override
  State<FavouriteTile> createState() => _FavouriteTileState();
}

class _FavouriteTileState extends State<FavouriteTile> {
  void deleteFav(int newId) {
    context.read<FavouriteDatabase>().deleteFavourite(newId);
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
                    )));
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
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        widget.image,
                        opacity: const AlwaysStoppedAnimation(0.7),
                      )),
                )),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10),
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 50) / 2,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontFamily: 'Ariel',
                          fontSize: 16,
                          color: Colors.grey.shade600),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {
                      deleteFav(widget.realId);
                      Fluttertoast.showToast(
                          msg: 'Removed',
                          fontSize: 18,
                          textColor: Colors.grey.shade800,
                          backgroundColor: Colors.grey.shade300,
                          toastLength: Toast.LENGTH_SHORT);
                    },
                    icon: const Icon(Icons.delete)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
