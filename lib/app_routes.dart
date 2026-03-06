import 'package:flutter/material.dart';

import 'main.dart';
import 'presentation/games/games_screen.dart';
import 'presentation/create_new_game/create_new_game_screen.dart';
import 'presentation/players/players_screen.dart';

class AppRoutes {
  static const String root = '/';

  // Games
  static const String games = '/games';
  static const String createNewGame = '$games/create';

  // Players
  static const String players = '/players';

  // On generate route
  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) => switch (settings.name) {
    // Root
    root => MaterialPageRoute(
      settings: settings,
      builder: (_) => RootScreen(),
    ),

    // Unknown route
    _ => throw Exception('Unknown route: ${settings.name}'),
  };

  // Games routes
  static Route<dynamic>? onGamesRoute(
    RouteSettings settings,
  ) => switch (settings.name) {
    // Games
    root || games => MaterialPageRoute(
      settings: settings,
      builder: (_) => const GamesScreen(),
    ),

    // Create new game
    createNewGame => MaterialPageRoute(
      settings: settings,
      builder: (_) => const CreateNewGameScreen(),
    ),

    // Unknown route
    _ => throw Exception('Unknown route: ${settings.name}'),
  };

  // Players routes
  static Route<dynamic>? onPlayersRoute(
    RouteSettings settings,
  ) => switch (settings.name) {
    // Unknown route
    root || players => MaterialPageRoute(
      settings: settings,
      builder: (_) => PlayersScreen(),
    ),

    _ => throw Exception('Unknown route: ${settings.name}'),
  };
}
