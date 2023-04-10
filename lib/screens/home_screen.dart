import 'package:flutter/material.dart';
import 'package:score_keeper/screens/new_game_screen.dart';
import 'package:score_keeper/shared/db.dart';
import '../widgets/select_game_widget.dart';
import '../shared/game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Game> gamesList;

  Future<List<Game>> getGames() async {
    gamesList = await GamesDatabase.instance.getAllGames().whenComplete(() {
      setState(() {});
    });
    return gamesList;
  }

  Future deleteGame(int id) async {
    await GamesDatabase.instance.deleteGame(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 0,
                    child: MenuItemButton(
                      trailingIcon: Icon(
                        Icons.add_card,
                        color: Colors.green,
                      ),
                      child: Text(
                        "New Game",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ];
              },
              onSelected: (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewGameScreen()));
              },
            ),
          ],
          title: const Text('Score Keeper'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: getGames().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                            "No games yet, tap to create a new one now!"),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NewGameScreen()));
                          },
                          child: const Icon(
                            Icons.add_circle,
                            color: Colors.green,
                            size: 75,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: gamesList.length,
                    itemBuilder: (context, index) {
                      return SelectGame(
                        game: gamesList[index],
                        function: () {
                          deleteGame(gamesList[index].id!);
                          setState(() {
                            gamesList.removeAt(index);
                          });
                        },
                      );
                    },
                  );
                }
              },
            ))
          ],
        ));
  }
}
