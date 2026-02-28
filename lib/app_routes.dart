import 'package:flutter/material.dart';

import 'presentation/games/games_screen.dart';

class AppRoutes {
  static const String games = '/';

  // On generate route
  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) => switch (settings.name) {
    // Games
    games => MaterialPageRoute(
      builder: (context) => const GamesScreen(),
    ),

    // Unknown route
    _ => null,
  };
}
