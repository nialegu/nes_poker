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
  void createGame({
    required GamesCompanion gameCompanion,
  }) async {
    if (state is CreateNewGameLoading) return;

    try {
      emit(
        CreateNewGameLoading(
          players: state.players,
        ),
      );

      final game = await _repository.createGame(
        gameCompanion: gameCompanion,
        playerIds: state.players.map((player) => player.id).toList(),
      );

      emit(
        CreateNewGameSuccess(
          game: game,
          players: state.players,
        ),
      );
    } catch (error) {
      emit(
        CreateNewGameError(
          error: error.toString(),
          players: state.players,
        ),
      );
    }
  }

  // Add player ID
  void addPlayerId(Player player) {
    if (state is CreateNewGameLoading) return;
    emit(
      CreateNewGameInitial(
        players: state.players..add(player),
      ),
    );
  }
}
