import 'package:cookbook/model/favourite_database.dart';
import 'package:cookbook/pages/information_page.dart';
import 'package:cookbook/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Theme.of(context).colorScheme.secondary,
                      blurRadius: 7,
                      offset: const Offset(0.0, 0.0))
                ],
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Image.network(
                          widget.image,
                          opacity: AlwaysStoppedAnimation(
                              Provider.of<FavouriteDatabase>(context)
                                          .themeData ==
                                      lightmode
                                  ? 0.85
                                  : 0.6),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              createFavourite();
                              Fluttertoast.showToast(
                                  msg: 'Added To Favourites',
                                  fontSize: 18,
                                  textColor: Colors.grey.shade800,
                                  backgroundColor: Colors.grey.shade300,
                                  toastLength: Toast.LENGTH_SHORT);
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
                              color:
                                  Theme.of(context).colorScheme.primaryFixed),
                        ),
                      ))
                ],
              ),
            )));
  }
}
