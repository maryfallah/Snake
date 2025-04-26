// lib/game/snake.dart

import 'dart:math';
import 'dart:ui';

import 'package:snaker/game/direction.dart';

class Snake {
  final List<Point<int>> body;
  final Paint paint;
  final double cellSpacing;
  final double borderRadius;
  Direction currentDirection = Direction.right;

  Snake({
    required this.body,
    required this.paint,
    this.cellSpacing = 2.0,
    this.borderRadius = 4.0,
  });

  void render(
    Canvas canvas,
    double offsetX,
    double offsetY,
    double cellWidth,
    double cellHeight,
  ) {
    for (final segment in body) {
      final rect = Rect.fromLTWH(
        offsetX + segment.x * cellWidth + cellSpacing / 2,
        offsetY + segment.y * cellHeight + cellSpacing / 2,
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
}
