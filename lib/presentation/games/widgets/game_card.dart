import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/generated/l10n.dart';
import '../bloc/delete_game/delete_game_cubit.dart';
import '../bloc/games/games_bloc.dart';
import '/data/app_database.dart';
import '/extensions/date_time_extension.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    // Provide blocs
    return BlocProvider(
      create: (context) => DeleteGameCubit(gameId: game.id),

      // Listen to delete game cubit
      child: BlocListener<DeleteGameCubit, DeleteGameState>(
        listener: (context, state) {
          // Success
          if (state is DeleteGameSuccess) {
            context.read<GamesBloc>().add(GamesUpdate());
          }
        },

        // UI
        child: _UI(game: game),
      ),
    );
  }
}

// UI
class _UI extends StatelessWidget {
  final Game game;

  const _UI({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(game.name),
        subtitle: Text(game.createdAt.formattedDate),
        onLongPress: () {
          final renderBox = context.findRenderObject() as RenderBox;

          final size = renderBox.size;
          final offset = renderBox.localToGlobal(Offset.zero);

          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              offset.dx + size.width,
              offset.dy + size.height / 2,
              30,
              0,
            ),
            items: [
              // Delete
              PopupMenuItem(
                onTap: context.read<DeleteGameCubit>().deleteGame,
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                    ),
                    Text(
                      S.of(context).delete,
                      style: DefaultTextStyle.of(
                        context,
                      ).style.copyWith(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
