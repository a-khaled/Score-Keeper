import 'package:score_keeper/shared/player.dart';

class Game {
  int? id;
  final String name;
  final List<Player>? players;

  Game({this.id, required this.name, this.players});
}
