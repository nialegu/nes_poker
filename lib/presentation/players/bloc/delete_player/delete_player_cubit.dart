import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/repository/players_repository.dart';

part 'delete_player_state.dart';

class DeletePlayerCubit extends Cubit<DeletePlayerState> {
  final _repository = PlayersRepository();

  DeletePlayerCubit({required int playerId})
    : super(DeletePlayerInitial(playerId: playerId));

  // Delete player
  void deletePlayer() async {
    if (state is DeletePlayerLoading) return;

    try {
      emit(DeletePlayerLoading(playerId: state.playerId));
      await _repository.deletePlayerById(state.playerId);
      emit(DeletePlayerSuccess(playerId: state.playerId));
    } catch (e) {
      emit(DeletePlayerError(error: e.toString(), playerId: state.playerId));
    }
  }
}
