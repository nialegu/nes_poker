import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/app_routes.dart';
import '/core/widgets/app_circular_loader.dart';
import '/generated/l10n.dart';
import '../bloc/games/games_bloc.dart';
import '../widgets/game_card.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide games bloc
    return BlocProvider(
      create: (context) => GamesBloc()
        // Initially update
        ..add(GamesUpdate()),

      // UI
      child: Scaffold(
        // App bar
        appBar: AppBar(
          title: Text(S.of(context).games),
        ),

        // Add new game button
        floatingActionButton: _FloatingActionButton(),

        // Body
        body: BlocBuilder<GamesBloc, GamesState>(
          builder: (context, state) {
            // Empty case
            if (state.games.isEmpty) {
              return Center(
                child: switch (state) {
                  // Loading
                  GamesLoading() => AppCircularLoader(),

                  // Error
                  GamesError() => Text(state.message),

                  // Default
                  _ => Text(S.of(context).noData),
                },
              );
            }

            // Games list
            return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: state.games.length,
              itemBuilder: (context, index) => GameCard(
                game: state.games[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Open the screen of creating new game
class _FloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gamesBloc = context.read<GamesBloc>();

    return FloatingActionButton(
      onPressed: () async {
        final result = await Navigator.pushNamed(
          context,
          AppRoutes.createNewGame,
        );

        // Update games after succeded creating game
        if (result != null) {
          gamesBloc.add(GamesUpdate());
        }
      },
      child: Icon(Icons.add),
    );
  }
}
