import 'package:flutter/material.dart';

class InstructionsTile extends StatelessWidget {
  final int stepNo;
  final String step;
  const InstructionsTile({super.key, required this.step, required this.stepNo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: double.infinity,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 32),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 4, color: Theme.of(context).colorScheme.secondary)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text('Step $stepNo',
                      maxLines: 10,
                      style: TextStyle(
                          fontFamily: 'Ariel',
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primaryFixed)),
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                        child: Text(step,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Ariel',
                                fontSize: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryFixed)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
