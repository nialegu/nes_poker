import 'package:flutter/material.dart';

import '/data/app_database.dart';
import '/extensions/date_time_extension.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(game.name),
        subtitle: Text(game.createdAt.formatted),
      ),
    );
  }
}
