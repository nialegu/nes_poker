import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash until Flutter is ready
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsBinding,
  );

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    // Remove native splash
    Future.delayed(
      const Duration(seconds: 2),
      () {
        FlutterNativeSplash.remove();
      },
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NES Poker Cash Tools'),
        ),
      ),
    );
  }
}
