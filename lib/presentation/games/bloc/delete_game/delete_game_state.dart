part of 'delete_game_cubit.dart';

@immutable
sealed class DeleteGameState {
  final int gameId;

  const DeleteGameState({required this.gameId});
}

// Initial
final class DeleteGameInitial extends DeleteGameState {
  const DeleteGameInitial({required super.gameId});
}

// Success
final class DeleteGameSuccess extends DeleteGameState {
  const DeleteGameSuccess({required super.gameId});
}

// Loading
final class DeleteGameLoading extends DeleteGameState {
  const DeleteGameLoading({required super.gameId});
}

// Error
final class DeleteGameError extends DeleteGameState {
  final String error;

  const DeleteGameError({
    required this.error,
    required super.gameId,
  });
}
