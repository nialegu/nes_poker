part of 'games_bloc.dart';

@immutable
sealed class GamesState {
  final List<Game> games;

  const GamesState({required this.games});
}

// Initial
final class GamesInitial extends GamesState {
  GamesInitial() : super(games: []);
}

// Loaded
final class GamesLoaded extends GamesState {
  const GamesLoaded({required super.games});
}

// Loading
final class GamesLoading extends GamesState {
  const GamesLoading({required super.games});
}

// Error
final class GamesError extends GamesState {
  final String message;

  const GamesError({
    required super.games,
    required this.message,
  });
}
