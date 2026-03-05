part of 'create_new_game_cubit.dart';

@immutable
sealed class CreateNewGameState {}

// Initial
final class CreateNewGameInitial extends CreateNewGameState {}

// Success
final class CreateNewGameSuccess extends CreateNewGameState {}

// Loading
final class CreateNewGameLoading extends CreateNewGameState {}

// Error
final class CreateNewGameError extends CreateNewGameState {
  final String error;

  CreateNewGameError({required this.error});
}
