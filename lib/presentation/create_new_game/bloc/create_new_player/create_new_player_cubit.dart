import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/data/app_database.dart';
import '/repository/players_repository.dart';

part 'create_new_player_state.dart';

class CreateNewPlayerCubit extends Cubit<CreateNewPlayerState> {
  // Repository
  final _repository = PlayersRepository();

  CreateNewPlayerCubit() : super(CreateNewPlayerInitial());

  // Create new game
  void createPlayer({
    required PlayersCompanion playerCompanion,
  }) async {
    if (state is CreateNewPlayerLoading) return;

    try {
      emit(CreateNewPlayerLoading());

      final player = await _repository.createPlayer(
        playerCompanion: playerCompanion,
      );

      emit(CreateNewPlayerSuccess(player: player));
    } catch (error) {
      emit(CreateNewPlayerError(error: error.toString()));
    }
  }
}
