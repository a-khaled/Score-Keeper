import 'package:score_keeper/shared/player.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'game.dart';

class GamesDatabase {
  static const gamesTable = 'games';
  static const gameId = 'game_id';
  static const gameName = 'game_name';

  static const playersTable = 'players';
  static const playerId = 'player_id';
  static const playerName = 'player_name';
  static const score = 'score';

  static final GamesDatabase instance = GamesDatabase._init();

  static Database? _database;

  GamesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('games.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $gamesTable (
  $gameId INTEGER PRIMARY KEY AUTOINCREMENT,
  $gameName TEXT NOT NULL,)''');
    await db.execute('''
CREATE TABLE $playersTable (
  $playerId INTEGER PRIMARY KEY AUTOINCREMENT,
  $playerName TEXT NOT NULL,
  $score INTEGER,
  $gameId INTEGER NOT NULL,
  FOREIGN KEY ($gameId)
    REFERENCES $gamesTable ($gameId),)''');
  }

  Future<void> createGame(Game game) async {
    final db = await instance.database;
    final id = await db.insert(gamesTable, <String, Object?>{
      gameName: game.name,
    });
    game.id = id;
    final list = game.players;
    for (Player player in list!) {
      await db.insert(playersTable, <String, Object?>{
        playerName: player.name,
        score: player.score,
        gameId: game.id,
      });
    }
  }

  Future<List<Game>> getAllGames() async {
    final db = await instance.database;
    final List<Map> maps = await db.query(gamesTable);
    return List.generate(maps.length, (index) {
      return Game(id: maps[index][gameId], name: maps[index][gameName]);
    });
  }

  Future<List<Player>> getPlayers(int selectedGameId) async {
    final db = await instance.database;
    List<Map> maps = await db.query(playersTable,
        columns: [playerId, playerName, score, gameId],
        where: '$gameId = ?',
        whereArgs: [selectedGameId]);
    List<Player> players = [];
    if (maps.isNotEmpty) {
      maps.forEach((element) {
        Player player = Player(
            id: element[playerId],
            name: element[playerName],
            score: element[score]);
        players.add(player);
      });
    }
    return players;
  }

  Future<void> updateScore(Player player) async {
    final db = await instance.database;
    await db.update(
      playersTable,
      player.toMap(),
      where: '$playerId = ?',
      whereArgs: [player.id],
    );
  }

  Future<void> deleteGame(int id) async {
    final db = await instance.database;
    await db.delete(gamesTable, where: '$gameId = ?', whereArgs: [id]);
    await db.delete(playersTable, where: '$gameId = ?', whereArgs: [id]);
  }
}
