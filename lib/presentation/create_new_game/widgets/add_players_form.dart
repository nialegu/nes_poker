import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/app_database.dart';
import '../bloc/create_new_game/create_new_game_cubit.dart';
import 'create_player_form.dart';

class AddPlayersForm extends StatefulWidget {
  const AddPlayersForm({super.key});

  @override
  State<AddPlayersForm> createState() => _AddPlayersFormState();
}

class _AddPlayersFormState extends State<AddPlayersForm> {
  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Players
        _Players(),

        // Create player forms
        if (_isCreating)
          CreatePlayerForm(
            onCancel: () => setState(
              () => _isCreating = false,
            ),
          ),

        // Add player button
        ElevatedButton(
          onPressed: _isCreating
              ? null
              : () => setState(
                  () => _isCreating = true,
                ),
          child: Row(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add),
              Text('Add player'),
            ],
          ),
        ),
      ],
    );
  }
}

// Players
class _Players extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateNewGameCubit, CreateNewGameState, List<Player>>(
      selector: (state) => state.players,
      builder: (context, players) => Wrap(
        spacing: 15,
        runSpacing: 15,
        children: List.generate(
          players.length,
          (index) => Chip(
            label: Text(players[index].name),
          ),
        ),
      ),
    );
  }
}
