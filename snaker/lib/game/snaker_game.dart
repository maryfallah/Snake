import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SnakerGame extends FlameGame {
  late double eachCellSize;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Setup
    // Calculate cell size
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Game Logic
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
    final cellSpacing = 2.0;
    final borderRadius = 4.0;

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

    // Snake body with 3 cells
    final snakeBody = [
      const Point<int>(10, 10),
      const Point<int>(9, 10),
      const Point<int>(8, 10),
    ];
    final snakePaint = Paint()..color = const Color(0xFF00FF00); // Bright green

    // Draw each part of the snake
    for (final segment in snakeBody) {
      final snakeRect = Rect.fromLTWH(
        offsetX + segment.x * cellWidth + cellSpacing / 2,
        offsetY + segment.y * cellHeight + cellSpacing / 2,
        cellWidth - cellSpacing,
        cellHeight - cellSpacing,
      );
      // Draw snake block
      final snakeRRect = RRect.fromRectAndRadius(
        snakeRect,
        Radius.circular(borderRadius),
      );
      canvas.drawRRect(snakeRRect, snakePaint);
    }
  }
}
