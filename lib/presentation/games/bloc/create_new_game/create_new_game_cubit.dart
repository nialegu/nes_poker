import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/data/app_database.dart';
import '/repository/games_repository.dart';

part 'create_new_game_state.dart';

class CreateNewGameCubit extends Cubit<CreateNewGameState> {
  // Repository
  final _repository = GamesRepository();

  CreateNewGameCubit() : super(CreateNewGameInitial());

  // Create new game
  void create({
    required GamesCompanion game,
    required List<int> playerIds,
  }) async {
    if (state is CreateNewGameLoading) return;

    try {
      emit(CreateNewGameLoading());

      await _repository.createGame(
        game: game,
        playerIds: playerIds,
      );

      emit(CreateNewGameSuccess());
    } catch (error) {
      emit(CreateNewGameError(error: error.toString()));
    }
  }
}
