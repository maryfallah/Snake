import 'dart:math';
import 'direction.dart';
import 'snake.dart';

extension SnakeMovement on Snake {
  void move() {
    final head = body.first;
    late Point<int> newHead;

    switch (currentDirection) {
      case Direction.up:
        newHead = Point(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Point(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Point(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Point(head.x + 1, head.y);
        break;
    }

    body.insert(0, newHead);
    body.removeLast();
  }
}
