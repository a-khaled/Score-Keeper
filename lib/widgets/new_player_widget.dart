import 'package:flutter/material.dart';

class NewPlayer extends StatelessWidget {
  final String name;
  final Function function;
  const NewPlayer({super.key, required this.name, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: () {
                    function();
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  )),
            ],
          ),
        ]));
  }
}
