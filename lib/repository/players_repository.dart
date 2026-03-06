import 'package:drift/drift.dart';

import '../data/app_database.dart';
import 'app_repository.dart';

class PlayersRepository extends AppRepository {
  // Fetch the list of players
  Future<List<Player>> fetchPlayers() async =>
      await database.players.select().get();

  // Create player
  Future<Player> createPlayer({
    required PlayersCompanion playerCompanion,
  }) async => await database.players.insertReturning(playerCompanion);

  // Delete player
  Future<void> deletePlayerById({required int id}) async =>
      await database.players.deleteWhere(
        (tbl) => tbl.id.equals(id),
      );
}
