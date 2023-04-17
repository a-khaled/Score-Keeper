import 'package:flutter/material.dart';
import 'package:score_keeper/widgets/player_ingame_widget.dart';
import '../shared/player.dart';
import '../shared/db.dart';
import '../widgets/add_player_dialog.dart';

class GameStartScreen extends StatefulWidget {
  final int? gameId;
  const GameStartScreen({super.key, this.gameId});

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  late List<Player> playersList;
  bool plusOrMinus = true;
  bool _isLoading = false;
  String result = "";

  Future<List<Player>> getPlayers() async {
    setState(() {
      _isLoading = true;
    });
    playersList = await GamesDatabase.instance
        .getPlayers(widget.gameId!)
        .whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
    return playersList;
  }

  Future addPlayer(Player player) async {
    await GamesDatabase.instance.addPlayer(player, widget.gameId!);
  }

  Future updateScore(Player player) async {
    await GamesDatabase.instance.updateScore(player);
  }

  @override
  void initState() {
    getPlayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Game Start"),
        actions: [
          IconButton(
              onPressed: () {
                AddPlayerDialog.dialog(context, () {
                  setState(() {
                    result = AddPlayerDialog.newPLayerName;
                  });
                  if (result.isNotEmpty) {
                    Player player = Player(name: result, score: 0);
                    setState(() {
                      playersList.add(player);
                      addPlayer(player);
                      result = "";
                    });
                  }
                });
              },
              icon: const Icon(Icons.add_circle)),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Expanded(
                  child: StreamBuilder(
                      stream: getPlayers().asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: playersList.length,
                              itemBuilder: (context, index) {
                                return PlayerIngame(
                                  player: playersList[index],
                                  function1: () {
                                    setState(() {
                                      playersList[index].score--;
                                      updateScore(playersList[index]);
                                    });
                                  },
                                  function2: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            return AlertDialog(
                                              title: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                child: Center(
                                                  child: Text(
                                                      "${playersList[index].name}      ${playersList[index].score}"),
                                                ),
                                              ),
                                              content: SizedBox(
                                                height: 150,
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (plusOrMinus) {
                                                              playersList[index]
                                                                  .score += 5;
                                                            } else {
                                                              playersList[index]
                                                                  .score -= 5;
                                                            }

                                                            updateScore(
                                                                playersList[
                                                                    index]);
                                                          });
                                                          this.setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            plusOrMinus
                                                                ? "+5"
                                                                : "-5",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (plusOrMinus) {
                                                              playersList[index]
                                                                  .score += 10;
                                                            } else {
                                                              playersList[index]
                                                                  .score -= 10;
                                                            }
                                                            updateScore(
                                                                playersList[
                                                                    index]);
                                                          });
                                                          this.setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            plusOrMinus
                                                                ? "+10"
                                                                : "-10",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (plusOrMinus) {
                                                              playersList[index]
                                                                  .score += 25;
                                                            } else {
                                                              playersList[index]
                                                                  .score -= 25;
                                                            }
                                                            updateScore(
                                                                playersList[
                                                                    index]);
                                                          });
                                                          this.setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            plusOrMinus
                                                                ? "+25"
                                                                : "-25",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (plusOrMinus) {
                                                              playersList[index]
                                                                  .score += 50;
                                                            } else {
                                                              playersList[index]
                                                                  .score -= 50;
                                                            }
                                                            updateScore(
                                                                playersList[
                                                                    index]);
                                                          });
                                                          this.setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            plusOrMinus
                                                                ? "+50"
                                                                : "-50",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: plusOrMinus
                                                                ? Colors.white
                                                                : Colors.green,
                                                            shape: BoxShape
                                                                .circle),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              if (plusOrMinus) {
                                                                setState(() {
                                                                  plusOrMinus =
                                                                      false;
                                                                });
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons.remove,
                                                              size: 30,
                                                            )),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        width: 50,
                                                        color: Colors.grey,
                                                        child: TextFormField(
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          onFieldSubmitted:
                                                              (value) {
                                                            if (plusOrMinus) {
                                                              setState(() {
                                                                playersList[index]
                                                                        .score +=
                                                                    int.parse(
                                                                        value);
                                                                updateScore(
                                                                    playersList[
                                                                        index]);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              this.setState(
                                                                  () {});
                                                            } else {
                                                              setState(() {
                                                                playersList[index]
                                                                        .score -=
                                                                    int.parse(
                                                                        value);
                                                                updateScore(
                                                                    playersList[
                                                                        index]);
                                                              });
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              this.setState(
                                                                  () {});
                                                            }
                                                          },
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: plusOrMinus
                                                                ? Colors.green
                                                                : Colors.white,
                                                            shape: BoxShape
                                                                .circle),
                                                        child: IconButton(
                                                            onPressed: () {
                                                              if (!plusOrMinus) {
                                                                setState(() {
                                                                  plusOrMinus =
                                                                      true;
                                                                });
                                                              }
                                                            },
                                                            icon: const Icon(
                                                              Icons.add_rounded,
                                                              size: 30,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            );
                                          });
                                        });
                                  },
                                  function3: () {
                                    setState(() {
                                      playersList[index].score++;
                                      updateScore(playersList[index]);
                                    });
                                  },
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })),
            ]),
    );
  }
}
