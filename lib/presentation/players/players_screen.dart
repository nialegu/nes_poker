import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/widgets/app_circular_loader.dart';
import '/core/bloc/players/players_bloc.dart';
import '/generated/l10n.dart';
import 'widgets/player_card.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  Widget build(BuildContext context) {
    // Provide player bloc
    return BlocProvider(
      create: (context) => PlayersBloc()..add(PlayersUpdate()),

      // UI
      child: Scaffold(
        // App bar
        appBar: AppBar(
          title: Text(S.of(context).players),
        ),

        // Body
        body: BlocBuilder<PlayersBloc, PlayersState>(
          builder: (_, state) {
            if (state.players.isEmpty) {
              return Center(
                child: switch (state) {
                  // Loading
                  PlayersLoading() => AppCircularLoader(),
                  // Error
                  PlayersError() => Text(state.message),
                  // Default
                  _ => Text(S.of(context).noData),
                },
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: state.players.length,
              itemBuilder: (_, index) => PlayerCard(
                player: state.players[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
