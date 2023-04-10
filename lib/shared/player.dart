class Player {
  final int? id;
  final String name;
  int score;
  Player({this.id, required this.name, required this.score});

  Map<String, dynamic> toMap() {
    return {'player_id': id, 'player_name': name, 'score': score};
  }
}
