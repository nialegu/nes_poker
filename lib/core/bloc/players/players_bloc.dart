import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';

import '/repository/players_repository.dart';
import '/data/app_database.dart';

part 'players_event.dart';
part 'players_state.dart';

class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final _repository = PlayersRepository();

  PlayersBloc() : super(PlayersInitial()) {
    // Update
    on<PlayersUpdate>(
      transformer: droppable(),
      (event, emit) async {
        try {
          emit(PlayersLoading(players: state.players));
          final response = await _repository.fetchPlayers();
          emit(PlayersLoaded(players: response));
        } catch (e) {
          emit(PlayersError(message: e.toString(), players: state.players));
        }
      },
    );

    // Fetch by game id
    on<PlayersFetchByGameId>(
      transformer: droppable(),
      (event, emit) async {
        try {
          emit(PlayersLoading(players: state.players));
          final response = await _repository.fetchPlayersByGameId(event.gameId);
          emit(PlayersLoaded(players: response));
        } catch (e) {
          emit(PlayersError(message: e.toString(), players: state.players));
        }
      },
    );
  }
}
