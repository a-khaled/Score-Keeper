import 'package:flutter/material.dart';
import 'package:score_keeper/widgets/player_ingame_widget.dart';
import '../shared/player.dart';
import '../shared/db.dart';

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

  Future getPlayers() async {
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
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              Expanded(
                  child: ListView.builder(
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
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Theme.of(context).primaryColor),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    playersList[index].score +=
                                                        5;
                                                    updateScore(
                                                        playersList[index]);
                                                  });
                                                  this.setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "+5",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    playersList[index].score +=
                                                        10;
                                                    updateScore(
                                                        playersList[index]);
                                                  });
                                                  this.setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "+10",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    playersList[index].score +=
                                                        25;
                                                    updateScore(
                                                        playersList[index]);
                                                  });
                                                  this.setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "+25",
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    playersList[index].score +=
                                                        50;
                                                    updateScore(
                                                        playersList[index]);
                                                  });
                                                  this.setState(() {});
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.all(5),
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "+50",
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: plusOrMinus
                                                        ? Colors.white
                                                        : Colors.green,
                                                    shape: BoxShape.circle),
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (plusOrMinus) {
                                                        setState(() {
                                                          plusOrMinus = false;
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
                                                      TextInputAction.done,
                                                  onFieldSubmitted: (value) {
                                                    if (plusOrMinus) {
                                                      setState(() {
                                                        playersList[index]
                                                                .score +=
                                                            int.parse(value);
                                                        updateScore(
                                                            playersList[index]);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      this.setState(() {});
                                                    } else {
                                                      setState(() {
                                                        playersList[index]
                                                                .score -=
                                                            int.parse(value);
                                                        updateScore(
                                                            playersList[index]);
                                                      });
                                                      Navigator.of(context)
                                                          .pop();
                                                      this.setState(() {});
                                                    }
                                                  },
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: plusOrMinus
                                                        ? Colors.green
                                                        : Colors.white,
                                                    shape: BoxShape.circle),
                                                child: IconButton(
                                                    onPressed: () {
                                                      if (!plusOrMinus) {
                                                        setState(() {
                                                          plusOrMinus = true;
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
                      })),
            ]),
    );
  }
}
