import 'package:drift/drift.dart';

import '/data/app_database.dart';
import 'app_repository.dart';

class GamesRepository extends AppRepository {
  /// Fetch the list of games
  Future<List<Game>> fetchGames() async => await database.games.select().get();

  /// Create game. Return an instance of a new game
  Future<Game> createGame({
    required GamesCompanion gameCompanion,
    required List<int> playerIds,
  }) async => await database.transaction(
    () async {
      // Create game
      final response = await database.games.insertReturning(gameCompanion);

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

  /// Delete game
  Future<void> deleteGameById(int id) async => await database.transaction(
    () async {
      // Delete game
      await database.games.deleteWhere((tbl) => tbl.id.equals(id));

      // Delete relations with players
      await database.gamePlayers.deleteWhere((tbl) => tbl.gameId.equals(id));
    },
  );
}
