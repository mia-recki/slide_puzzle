part of 'movement_cubit.dart';

extension on Puzzle {
  Tile? movableTile(Movement direction) {
    final whitespace = getWhitespaceTile();
    try {
      return tiles.firstWhere(
        (tile) => tile.currentPosition == whitespace.position(direction),
      );
    } catch (e) {
      return null;
    }
  }
}

extension on Tile {
  Position position(Movement direction) {
    switch (direction) {
      case Movement.none:
        return currentPosition;
      case Movement.up:
        return currentPosition.copyWith(y: currentPosition.y + 1);
      case Movement.down:
        return currentPosition.copyWith(y: currentPosition.y - 1);
      case Movement.left:
        return currentPosition.copyWith(x: currentPosition.x + 1);
      case Movement.right:
        return currentPosition.copyWith(x: currentPosition.x - 1);
    }
  }
}

extension on Position {
  Position copyWith({int? x, int? y}) => Position(
        x: x ?? this.x,
        y: y ?? this.y,
      );
}
