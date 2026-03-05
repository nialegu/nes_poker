import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/repository/games_repository.dart';

part 'delete_game_state.dart';

class DeleteGameCubit extends Cubit<DeleteGameState> {
  final _repository = GamesRepository();

  DeleteGameCubit({required int gameId})
    : super(DeleteGameInitial(gameId: gameId));

  // Delete game
  void deleteGame() async {
    if (state is DeleteGameLoading) return;

    try {
      emit(DeleteGameLoading(gameId: state.gameId));
      await _repository.deleteGameById(state.gameId);
      emit(DeleteGameSuccess(gameId: state.gameId));
    } catch (e) {
      emit(DeleteGameError(error: e.toString(), gameId: state.gameId));
    }
  }
}
