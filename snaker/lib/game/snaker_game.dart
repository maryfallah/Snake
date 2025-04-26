import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:snaker/game/direction.dart';
import 'package:snaker/game/snake.dart';
import 'package:snaker/game/snake_movement.dart';

class SnakerGame extends FlameGame {
  late double eachCellSize;
  late Snake snake;
  Direction get currentDirection => snake.currentDirection;
  bool hasChangedDirection = false;

  double moveTimer = 0.0;
  final double moveInterval = 0.2;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Setup
    snake = Snake(
      body: [
        const Point<int>(10, 10),
        const Point<int>(9, 10),
        const Point<int>(8, 10),
      ],
      paint: Paint()..color = const Color(0xFF3a86ff),
    );
    // Calculate cell size
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Game Logic
    moveTimer += dt; // Add how much time passed
    if (moveTimer >= moveInterval) {
      snake.move(); // Move the snake
      moveTimer = 0.0; // Reset timer
      hasChangedDirection = false;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final gameAreaWidth = size.x * 0.9;
    final gameAreaHeight = size.y * 0.9;
    // Centers the game area on the screen.
    final offsetX = (size.x - gameAreaWidth) / 2;
    final offsetY = (size.y - gameAreaHeight) / 2;

    const columns = 25;
    const rows = 45;
    final cellSpacing = 0;
    final borderRadius = 0.3;

    final cellWidth = gameAreaWidth / columns;
    final cellHeight = gameAreaHeight / rows;

    // Fill background with black
    final backgroundPaint = Paint()..color = const Color(0xFF000000);
    canvas.drawRect(
      Rect.fromLTWH(offsetX, offsetY, gameAreaWidth, gameAreaHeight),
      backgroundPaint,
    );

    final darkGreyPaint = Paint()..color = const Color(0xFF303030);
    final lightGreyPaint = Paint()..color = const Color(0xFF505050);

    for (int col = 0; col < columns; col++) {
      for (int row = 0; row < rows; row++) {
        final paint = (col + row) % 2 == 0 ? darkGreyPaint : lightGreyPaint;

        final rect = Rect.fromLTWH(
          offsetX + col * cellWidth + cellSpacing / 2,
          offsetY + row * cellHeight + cellSpacing / 2,
          cellWidth - cellSpacing,
          cellHeight - cellSpacing,
        );

        final rrect = RRect.fromRectAndRadius(
          rect,
          Radius.circular(borderRadius),
        );
        canvas.drawRRect(rrect, paint);
      }
    }

    // Draw a snake
    snake.render(canvas, offsetX, offsetY, cellWidth, cellHeight);
  }

  void changeDirection(Direction newDirection) {
    if (hasChangedDirection) return;
    // Prevent the snake from reversing directly
    if ((currentDirection == Direction.up && newDirection == Direction.down) ||
        (currentDirection == Direction.down && newDirection == Direction.up) ||
        (currentDirection == Direction.left &&
            newDirection == Direction.right) ||
        (currentDirection == Direction.right &&
            newDirection == Direction.left)) {
      return;
    }

    snake.currentDirection = newDirection;
    hasChangedDirection = true;
  }
}
