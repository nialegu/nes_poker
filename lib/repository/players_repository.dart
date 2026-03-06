import 'package:drift/drift.dart';

import '../data/app_database.dart';
import 'app_repository.dart';

class PlayersRepository extends AppRepository {
  // Fetch the list of players
  Future<List<Player>> fetchPlayers() async =>
      await database.players.select().get();

  // Fetch the list of players by game id
  Future<List<Player>> fetchPlayersByGameId(int gameId) async {
    final query = database.players.select().join([
      innerJoin(
        database.gamePlayers,
        database.gamePlayers.playerId.equalsExp(database.players.id),
      ),
    ])..where(database.gamePlayers.gameId.equals(gameId));

    final result = await query.get();
    return result.map((row) => row.readTable(database.players)).toList();
  }

  // Create player
  Future<Player> createPlayer({
    required PlayersCompanion playerCompanion,
  }) async => await database.players.insertReturning(playerCompanion);

  // Delete player
  Future<void> deletePlayerById(int id) async =>
      await database.players.deleteWhere(
        (tbl) => tbl.id.equals(id),
      );
}
