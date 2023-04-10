import 'package:flutter/material.dart';
import 'package:score_keeper/screens/game_start_screen.dart';
import 'package:score_keeper/shared/db.dart';
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
  final _formKey = GlobalKey<FormState>();
  int? gameId;
  bool _isLoading = false;

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
                      setState(() {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Enter Player Name"),
                                content: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    maxLength: 18,
                                    onChanged: (val) {
                                      setState(() {
                                        newPLayerName = val;
                                      });
                                    },
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return "player name can't be empty";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.person),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          Player newPlayer = Player(
                                              name: newPLayerName, score: 0);
                                          playersList.add(newPlayer);
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor),
                                    child: const Text("Add"),
                                  ),
                                ],
                              );
                            });
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
