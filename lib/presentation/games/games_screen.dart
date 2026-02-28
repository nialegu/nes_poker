import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/games_bloc.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide games bloc
    return BlocProvider(
      create: (context) => GamesBloc()..add(GamesFetch()),

      // UI
      child: Scaffold(
        appBar: AppBar(
          title: Text('Games'),
        ),
      ),
    );
  }
}
