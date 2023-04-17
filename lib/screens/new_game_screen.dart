import 'package:flutter/material.dart';
import 'package:score_keeper/screens/game_start_screen.dart';
import 'package:score_keeper/shared/db.dart';
import 'package:score_keeper/widgets/add_player_dialog.dart';
import '../shared/game.dart';
import '../shared/player.dart';
import '../widgets/new_player_widget.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final List<Player> playersList = [];
  String gameName = "";
  String newPLayerName = "";
  int? gameId;
  bool _isLoading = false;
  String result = "";

  Future createGame(Game game) async {
    setState(() {
      _isLoading = true;
    });
    await GamesDatabase.instance.createGame(game).whenComplete(() {
      setState(() {
        gameId = game.id;
        _isLoading = false;
      });
    });
  }

  doSomething() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text("New Game"),
                centerTitle: true,
              ),
              body: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        gameName = value;
                      },
                      maxLength: 22,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Name Your Game",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      AddPlayerDialog.dialog(context, () {
                        setState(() {
                          result = AddPlayerDialog.newPLayerName;
                        });
                        if (result.isNotEmpty) {
                          Player player = Player(name: result, score: 0);
                          setState(() {
                            playersList.add(player);
                            result = "";
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: const Text(
                        "Add a player",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  playersList.isEmpty
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              height: 300,
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.blue)),
                              padding: const EdgeInsets.all(5),
                              child: ListView.builder(
                                  itemCount: playersList.length,
                                  itemBuilder: (context, index) {
                                    return NewPlayer(
                                      name: playersList[index].name,
                                      function: () {
                                        setState(() {
                                          playersList.removeAt(index);
                                        });
                                      },
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (gameName.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Please Name your Game"),
                                    backgroundColor: Colors.red,
                                  ));
                                } else {
                                  Game game = Game(
                                      name: gameName, players: playersList);
                                  createGame(game).whenComplete(() {
                                    if (gameId != null) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GameStartScreen(
                                                    gameId: gameId!,
                                                  )));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Error Ouccurred")));
                                    }
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.blue,
                                ),
                                child: const Text(
                                  "Start Game",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          );
  }
}
