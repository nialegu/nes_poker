import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/widgets/app_circular_loader.dart';
import '/data/app_database.dart';
import 'bloc/create_new_game/create_new_game_cubit.dart';
import '/generated/l10n.dart';
import 'widgets/add_players_form.dart';

class CreateNewGameScreen extends StatelessWidget {
  const CreateNewGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide form cubit
    return BlocProvider(
      create: (context) => CreateNewGameCubit(),

      // Listen to form cubit states
      child: BlocListener<CreateNewGameCubit, CreateNewGameState>(
        listener: (context, state) {
          // Success
          if (state is CreateNewGameSuccess) {
            Navigator.pop(context, state.game);
          }
        },

        // UI
        child: Scaffold(
          // App bar
          appBar: AppBar(
            title: Text(S.of(context).createNewGame),
          ),

          // Form
          body: _Form(),
        ),
      ),
    );
  }
}

// Form
class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  late final TextEditingController _nameController;

  // Can save form
  late bool _canCreate;

  @override
  void initState() {
    super.initState();

    // Initialize text controllers
    _nameController = TextEditingController();

    // Can save form
    _canCreate = false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        // Form fields
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                TextFormField(
                  controller: _nameController,
                  onChanged: (value) {
                    if (value.isEmpty && _canCreate) {
                      setState(() => _canCreate = false);
                    } else if (value.isNotEmpty && !_canCreate) {
                      setState(() => _canCreate = true);
                    }
                  },
                  decoration: InputDecoration(
                    labelText: S.of(context).name,
                  ),
                ),

                // Add players form
                AddPlayersForm(),
              ],
            ),
          ),
        ),

        // Create button
        Positioned(
          bottom: 30,
          child: BlocSelector<CreateNewGameCubit, CreateNewGameState, bool>(
            selector: (state) => state is CreateNewGameLoading,
            builder: (context, isLoading) => ElevatedButton(
              onPressed: !_canCreate || isLoading
                  ? null
                  : () {
                      if (!_formKey.currentState!.validate()) {
                        // TODO
                      }

                      final formCubit = context.read<CreateNewGameCubit>();
                      final gameCompanion = GamesCompanion.insert(
                        name: _nameController.text,
                      );

                      formCubit.createGame(gameCompanion: gameCompanion);
                    },
              child: isLoading
                  ? AppCircularLoader()
                  : Text(S.of(context).create),
            ),
          ),
        ),
      ],
    );
  }
}
