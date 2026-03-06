import 'package:flutter/material.dart';

import 'presentation/create_new_game/create_new_game_screen.dart';
import 'presentation/games/games_screen.dart';

class AppRoutes {
  static const String games = '/games';
  static const String createNewGame = '$games/create';

  // On generate route
  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) => switch (settings.name) {
    // Games
    games => MaterialPageRoute(
      builder: (_) => const GamesScreen(),
    ),

    // Create new game
    createNewGame => MaterialPageRoute(
      builder: (_) => const CreateNewGameScreen(),
    ),

    // Unknown route
    _ => null,
  };
}
