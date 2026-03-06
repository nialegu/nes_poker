part of 'players_bloc.dart';

@immutable
sealed class PlayersState {
  final List<Player> players;

  const PlayersState({required this.players});
}

// Initial
final class PlayersInitial extends PlayersState {
  PlayersInitial() : super(players: []);
}

// Loaded
final class PlayersLoaded extends PlayersState {
  const PlayersLoaded({required super.players});
}

// Loading
final class PlayersLoading extends PlayersState {
  const PlayersLoading({required super.players});
}

// Error
final class PlayersError extends PlayersState {
  final String message;

  const PlayersError({
    required this.message,
    required super.players,
  });
}
