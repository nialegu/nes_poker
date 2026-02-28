import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/widgets/app_circular_loader.dart';
import '/generated/l10n.dart';
import 'bloc/games_bloc.dart';
import 'widgets/game_card.dart';

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
        // App bar
        appBar: AppBar(
          title: Text(S.of(context).games),
        ),

        // Add new game button
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),

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
