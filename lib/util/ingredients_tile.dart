import 'package:flutter/material.dart';

class IngredientsTile extends StatelessWidget {
  final String name;
  final String measurement;
  final double amount;
  const IngredientsTile(
      {super.key,
      required this.amount,
      required this.measurement,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromRGBO(177, 255, 199, 1),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 4, color: Color.fromRGBO(102, 180, 124, 1))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      name,
                      style: TextStyle(
                          fontFamily: 'Ariel',
                          fontSize: 12,
                          color: Colors.grey.shade700),
                    ),
                  ),
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        '$amount $measurement',
                        style: TextStyle(
                            fontFamily: 'Ariel',
                            fontSize: 12,
                            color: Colors.grey.shade700),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
