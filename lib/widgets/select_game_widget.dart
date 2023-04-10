import 'package:flutter/material.dart';
import 'package:score_keeper/screens/game_start_screen.dart';
import 'package:score_keeper/shared/game.dart';

class SelectGame extends StatelessWidget {
  final Game game;
  final Function function;
  const SelectGame({super.key, required this.game, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => GameStartScreen(
                  gameId: game.id,
                ))));
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.games,
              size: 30,
              color: Colors.green,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              game.name,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  function();
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
