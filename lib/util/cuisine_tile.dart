import 'dart:developer';
import 'package:flutter/material.dart';

class CuisineTile extends StatelessWidget {
  final String cuisineName;
  const CuisineTile({super.key, required this.cuisineName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log('message');
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 10),
          decoration: BoxDecoration(boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(102, 180, 124, 1), blurRadius: 4, offset: Offset(0.0, 0.0))
          ], borderRadius: BorderRadius.circular(100), color:const Color.fromRGBO(177, 255, 199, 1)),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(cuisineName,style: const TextStyle(fontFamily: 'Ariel',fontSize: 18,color: Color.fromRGBO(0, 70, 20, 1)),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
