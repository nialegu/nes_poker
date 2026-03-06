import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_routes.dart';
import 'generated/l10n.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash until Flutter is ready
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );

  runApp(const Application());

  // Remove native splash
  Future.delayed(
    const Duration(seconds: 1),
    () => FlutterNativeSplash.remove(),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Theme
      theme: ThemeData.dark(),

      // Localization
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Routing
      initialRoute: AppRoutes.root,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

// Root screen
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  // Navigator keys
  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // Build navigator
  Widget _buildNavigator(int index) => Navigator(
    key: _navigatorKeys[index],
    onGenerateRoute: (settings) {
      if (settings.name == AppRoutes.root) {
        settings = RouteSettings(
          name: switch (index) {
            0 => AppRoutes.games,
            1 => AppRoutes.players,
            _ => AppRoutes.root,
          },
          arguments: settings.arguments,
        );
      }

      return switch (index) {
        // Games
        0 => AppRoutes.onGamesRoute(settings),
        // Players
        1 => AppRoutes.onPlayersRoute(settings),
        // Default
        _ => null,
      };
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: IndexedStack(
        index: _index,
        children: [
          _buildNavigator(0),
          _buildNavigator(1),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: [
          // Games
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: S.of(context).games,
          ),

          // Players
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: S.of(context).players,
          ),
        ],
      ),
    );
  }
}
