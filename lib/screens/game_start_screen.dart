import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:score_keeper/widgets/player_ingame_widget.dart';
import '../shared/player.dart';

class GameStartScreen extends StatefulWidget {
  final List<Player> playersList;
  const GameStartScreen({super.key, required this.playersList});

  @override
  State<GameStartScreen> createState() => _GameStartScreenState();
}

class _GameStartScreenState extends State<GameStartScreen> {
  bool plusOrMinus = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Game Start"),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
              itemCount: widget.playersList.length,
              itemBuilder: (context, index) {
                return PlayerIngame(
                  player: widget.playersList[index],
                  function1: () {
                    setState(() {
                      widget.playersList[index].score--;
                    });
                  },
                  function2: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                child: Center(
                                  child: Text(
                                      "${widget.playersList[index].name}      ${widget.playersList[index].score}"),
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
                                            widget.playersList[index].score +=
                                                5;
                                          });
                                          this.setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: const Text(
                                            "+5",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.playersList[index].score +=
                                                10;
                                          });
                                          this.setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: const Text(
                                            "+10",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.playersList[index].score +=
                                                25;
                                          });
                                          this.setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: const Text(
                                            "+25",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.playersList[index].score +=
                                                50;
                                          });
                                          this.setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Colors.black,
                                            ),
                                          ),
                                          child: const Text(
                                            "+50",
                                            style: TextStyle(fontSize: 20),
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
                                          textInputAction: TextInputAction.done,
                                          onFieldSubmitted: (value) {
                                            if (plusOrMinus) {
                                              setState(() {
                                                widget.playersList[index]
                                                    .score += int.parse(value);
                                              });
                                              Navigator.of(context).pop();
                                              this.setState(() {});
                                            } else {
                                              setState(() {
                                                widget.playersList[index]
                                                    .score -= int.parse(value);
                                              });
                                              Navigator.of(context).pop();
                                              this.setState(() {});
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
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
                      widget.playersList[index].score++;
                    });
                  },
                );
              }),
        ),
      ]),
    );
  }

  // scoreButton(int score, int added) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         score += added;
  //       });

  //       Navigator.of(context).pop();
  //     },
  //     child: Container(
  //       margin: const EdgeInsets.all(5),
  //       padding: const EdgeInsets.all(10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5),
  //         border: Border.all(
  //           color: Colors.black,
  //         ),
  //       ),
  //       child: Text(
  //         "+${added.toString()}",
  //         style: const TextStyle(fontSize: 20),
  //       ),
  //     ),
  //   );
  // }
}
