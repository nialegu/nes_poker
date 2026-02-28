import '/data/app_database.dart';

class GamesRepository {
  // Database instance
  final database = AppDatabase();

  // Fetch games
  Future<List<Game>> fetchGames() async =>
      await database.select(database.games).get();
}
