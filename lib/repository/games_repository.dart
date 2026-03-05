import '/data/app_database.dart';

class GamesRepository {
  // Database instance
  final database = AppDatabase();

  /// Fetch the list of games
  Future<List<Game>> fetchGames() async =>
      await database.select(database.games).get();

  /// Create game. Return an instance of a new game
  Future<Game> createGame({
    required GamesCompanion gameCompanion,
    required List<int> playerIds,
  }) async => await database.transaction(
    () async {
      // Create game
      final response = await database
          .into(database.games)
          .insertReturning(gameCompanion);

      // Create relations between game and players
      await database.batch(
        (batch) => batch.insertAll(
          database.gamePlayers,
          playerIds.map(
            (playerId) => GamePlayersCompanion.insert(
              gameId: response.id,
              playerId: playerId,
            ),
          ),
        ),
      );

      return response;
    },
  );
}
