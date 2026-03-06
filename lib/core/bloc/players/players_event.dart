part of 'players_bloc.dart';

@immutable
sealed class PlayersEvent {}

// Update
final class PlayersUpdate extends PlayersEvent {}

// Fetch by game id
final class PlayersFetchByGameId extends PlayersEvent {
  final int gameId;

  PlayersFetchByGameId({required this.gameId});
}
