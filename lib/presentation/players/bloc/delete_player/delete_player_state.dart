part of 'delete_player_cubit.dart';

@immutable
sealed class DeletePlayerState {
  final int playerId;

  const DeletePlayerState({required this.playerId});
}

// Initial
final class DeletePlayerInitial extends DeletePlayerState {
  const DeletePlayerInitial({required super.playerId});
}

// Success
final class DeletePlayerSuccess extends DeletePlayerState {
  const DeletePlayerSuccess({required super.playerId});
}

// Loading
final class DeletePlayerLoading extends DeletePlayerState {
  const DeletePlayerLoading({required super.playerId});
}

// Error
final class DeletePlayerError extends DeletePlayerState {
  final String error;

  const DeletePlayerError({
    required this.error,
    required super.playerId,
  });
}
