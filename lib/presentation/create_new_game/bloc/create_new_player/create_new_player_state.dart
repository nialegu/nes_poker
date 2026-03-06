part of 'create_new_player_cubit.dart';

@immutable
sealed class CreateNewPlayerState {}

// Initial
final class CreateNewPlayerInitial extends CreateNewPlayerState {}

// Success
final class CreateNewPlayerSuccess extends CreateNewPlayerState {
  final Player player;

  CreateNewPlayerSuccess({required this.player});
}

// Loading
final class CreateNewPlayerLoading extends CreateNewPlayerState {}

// Error
final class CreateNewPlayerError extends CreateNewPlayerState {
  final String error;

  CreateNewPlayerError({required this.error});
}
