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
        decoration: const BoxDecoration(
            color: Color.fromRGBO(177, 255, 199, 1),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 4, color: Color.fromRGBO(102, 180, 124, 1))
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
                          color: Colors.grey.shade700)),
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
                                color: Colors.grey.shade700)))
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
