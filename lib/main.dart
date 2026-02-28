import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app_routes.dart';

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

      // Routing
      initialRoute: AppRoutes.games,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
