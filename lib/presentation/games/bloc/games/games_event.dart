part of 'games_bloc.dart';

@immutable
sealed class GamesEvent {}

final class GamesFetch extends GamesEvent {}
