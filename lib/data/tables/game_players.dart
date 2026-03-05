import 'package:drift/drift.dart';

import 'games.dart';
import 'players.dart';

@DataClassName('GamePlayer')
class GamePlayers extends Table {
  // Game ID
  late final gameId = integer().references(Games, #id)();

  // Player ID
  late final playerId = integer().references(Players, #id)();

  @override
  Set<Column> get primaryKey => {gameId, playerId};
}
