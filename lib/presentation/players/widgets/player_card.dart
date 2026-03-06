import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/bloc/players/players_bloc.dart';
import '../bloc/delete_player/delete_player_cubit.dart';
import '/generated/l10n.dart';
import '/data/app_database.dart';

class PlayerCard extends StatelessWidget {
  final Player player;

  const PlayerCard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    // Provide delete cubit
    return BlocProvider(
      key: ValueKey(player.id),
      create: (context) => DeletePlayerCubit(playerId: player.id),

      // Listen to success deleting
      child: BlocListener<DeletePlayerCubit, DeletePlayerState>(
        listener: (context, state) {
          if (state is DeletePlayerSuccess) {
            final playersBloc = context.read<PlayersBloc>();
            playersBloc.add(PlayersUpdate());
          }
        },

        // UI
        child: _UI(player: player),
      ),
    );
  }
}

class _UI extends StatelessWidget {
  final Player player;

  const _UI({required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onLongPress: () => _onLongPress(context),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(player.name),
        ),
      ),
    );
  }

  // On long press
  void _onLongPress(BuildContext context) {
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
          onTap: context.read<DeletePlayerCubit>().deletePlayer,
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
  }
}
