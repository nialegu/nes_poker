import 'package:flutter/material.dart';
import 'package:nes_poker_cash_tools/presentation/home/home_screen.dart';

class AppRoutes {
  static const String home = '/';

  // On generate route
  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) => switch (settings.name) {
    // Home
    home => MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    ),

    // Unknown route
    _ => null,
  };
}
