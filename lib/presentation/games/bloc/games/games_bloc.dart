import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/data/app_database.dart';
import '/repository/games_repository.dart';

part 'games_event.dart';
part 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  // Repository
  final _repository = GamesRepository();

  GamesBloc() : super(GamesInitial()) {
    // Update games
    on<GamesUpdate>(
      (event, emit) async {
        emit(GamesLoading(games: state.games));
        try {
          final games = await _repository.fetchGames();
          emit(GamesLoaded(games: games));
        } catch (e) {
          if (!isClosed) {
            emit(
              GamesError(
                games: state.games,
                message: e.toString(),
              ),
            );
          }
        }
      },
    );
  }
}
