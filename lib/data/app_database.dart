import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables/game_players.dart';
import 'tables/games.dart';
import 'tables/players.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Games,
    GamePlayers,
    Players,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// [AppDatabase] instance is used as a singleton
  factory AppDatabase() => _instance;

  static final _instance = AppDatabase._internal();

  AppDatabase._internal() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'nes_poker_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
