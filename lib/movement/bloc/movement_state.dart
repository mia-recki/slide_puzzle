import 'package:tilt/tilt.dart';
import 'package:very_good_slide_puzzle/models/tile.dart';
import 'package:very_good_slide_puzzle/movement/bloc/movement_cubit.dart';

const tiltTriggerDegrees = 22.5;

class MovementState {
  MovementState._(this.tilt, this.movementCandidate, this.swapHistory);

  factory MovementState.initial() => MovementState._(
        const Tilt(0, 0),
        null,
        const [Movement.none],
      );

  final Tilt tilt;
  final Tile? movementCandidate;
  final List<Movement> swapHistory;

  double get xTilt => tilt.xDegrees.abs() > tilt.yDegrees.abs() ? (tilt.xDegrees / tiltTriggerDegrees).clamp(-1, 1) : 0;
  double get yTilt => tilt.yDegrees.abs() > tilt.xDegrees.abs() ? (tilt.yDegrees / tiltTriggerDegrees).clamp(-1, 1) : 0;

  MovementState swap(Movement direction) => MovementState._(
        tilt,
        null,
        [...swapHistory, direction],
      );

  MovementState copyWith(Tilt? tilt, Tile? movementCandidate) => MovementState._(
        tilt ?? this.tilt,
        movementCandidate ?? this.movementCandidate,
        swapHistory,
      );
}
