import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_new_game/create_new_game_cubit.dart';
import '/core/widgets/app_circular_loader.dart';
import '/data/app_database.dart';
import '../bloc/create_new_player/create_new_player_cubit.dart';
import '/generated/l10n.dart';

class CreatePlayerForm extends StatefulWidget {
  final VoidCallback onCancel;

  const CreatePlayerForm({
    super.key,
    required this.onCancel,
  });

  @override
  State<CreatePlayerForm> createState() => _CreatePlayerFormState();
}

class _CreatePlayerFormState extends State<CreatePlayerForm> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNewPlayerCubit(),

      // Listen to success
      child: BlocConsumer<CreateNewPlayerCubit, CreateNewPlayerState>(
        listener: (context, state) {
          if (state is CreateNewPlayerSuccess) {
            final createGameCubit = context.read<CreateNewGameCubit>();
            createGameCubit.addPlayerId(state.player);

            // Close form
            widget.onCancel();
          }
        },

        // UI
        builder: (context, state) {
          final isLoading = state is CreateNewPlayerLoading;

          return Row(
            children: [
              // Text field
              Expanded(
                child: TextFormField(
                  readOnly: isLoading,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: S.of(context).player,
                    hintText: S.of(context).name,
                  ),
                ),
              ),

              // Cancel
              IconButton(
                onPressed: isLoading ? null : widget.onCancel,
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),

              // Save
              IconButton(
                onPressed: isLoading
                    ? null
                    : () {
                        final companion = PlayersCompanion.insert(
                          name: _nameController.text,
                        );

                        context.read<CreateNewPlayerCubit>().createPlayer(
                          playerCompanion: companion,
                        );
                      },
                icon: isLoading
                    ? AppCircularLoader()
                    : Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
