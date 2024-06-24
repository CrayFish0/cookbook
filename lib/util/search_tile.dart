import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  const SearchTile(
      {super.key, required this.id, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          log('$id $image $title');
          log((MediaQuery.of(context).size.width).toString());
        },
        child: Padding(
            padding: EdgeInsets.all(24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(177, 255, 199, 1),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Column(children: [
                Card(
                  elevation: 0,
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height:10)
                ,
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(title,maxLines: 2,style: TextStyle(fontFamily: 'Ariel',fontSize: 16),))
                  ],
                )
              ]),
            ))
        /*const Padding(
        padding: EdgeInsets.all(24),
      ),*/
        );
  }
}/* 
 Container(
              width: MediaQuery.of(context).size.width - 50,
              color: Colors.green,
            ))*/