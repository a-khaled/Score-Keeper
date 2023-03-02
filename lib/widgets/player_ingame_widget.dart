import 'package:flutter/material.dart';
import '../shared/player.dart';

class PlayerIngame extends StatelessWidget {
  final Player player;

  final Function function1, function2, function3;
  const PlayerIngame(
      {super.key,
      required this.player,
      required this.function1,
      required this.function2,
      required this.function3});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Icon(
              Icons.person,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              player.name,
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  function1();
                },
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).primaryColor,
                )),
            const SizedBox(
              width: 12,
            ),
            GestureDetector(
                onTap: () {
                  function2();
                },
                child: Text(player.score.toString(),
                    style: const TextStyle(fontSize: 25))),
            const SizedBox(
              width: 12,
            ),
            IconButton(
                onPressed: () {
                  function3();
                },
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ),
      ]),
    );
  }
}
