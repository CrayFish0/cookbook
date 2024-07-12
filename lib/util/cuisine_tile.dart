import 'package:cookbook/pages/cuisine_page.dart';
import 'package:flutter/material.dart';

class CuisineTile extends StatelessWidget {
  final String cuisineName;
  const CuisineTile({super.key, required this.cuisineName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CuisinePage(
                      currentName: cuisineName,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 10),
          decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Theme.of(context).colorScheme.secondary,
                    blurRadius: 4,
                    offset: const Offset(0.0, 0.0))
              ],
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).colorScheme.primary),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  cuisineName,
                  style: TextStyle(
                      fontFamily: 'Ariel',
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primaryFixed),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
