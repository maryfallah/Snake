import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snaker/game/direction.dart';
import 'package:snaker/game/snaker_game.dart';

void main() {
  final game = SnakerGame();
  runApp(
    GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.delta.dy < 0) {
          game.changeDirection(Direction.up);
        } else if (details.delta.dy > 0) {
          game.changeDirection(Direction.down);
        }
      },
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < 0) {
          game.changeDirection(Direction.left);
        } else if (details.delta.dx > 0) {
          game.changeDirection(Direction.right);
        }
      },
      child: GameWidget(game: game),
    ),
  );
}
