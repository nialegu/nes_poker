part of 'create_new_game_cubit.dart';

@immutable
sealed class CreateNewGameState {
  final List<Player> players;

  const CreateNewGameState({required this.players});
}

// Initial
final class CreateNewGameInitial extends CreateNewGameState {
  CreateNewGameInitial({List<Player>? players}) : super(players: players ?? []);
}

// Success
final class CreateNewGameSuccess extends CreateNewGameState {
  final Game game;

  const CreateNewGameSuccess({
    required this.game,
    required super.players,
  });
}

// Loading
final class CreateNewGameLoading extends CreateNewGameState {
  const CreateNewGameLoading({required super.players});
}

// Error
final class CreateNewGameError extends CreateNewGameState {
  final String error;

  const CreateNewGameError({
    required this.error,
    required super.players,
  });
}
