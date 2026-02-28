import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/generated/l10n.dart';
import 'bloc/games_bloc.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide games bloc
    return BlocProvider(
      create: (context) => GamesBloc()
        // Initially update
        ..add(GamesFetch()),

      // UI
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).games),
        ),
      ),
    );
  }
}
