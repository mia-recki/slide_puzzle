import 'package:tilt/tilt.dart';
import 'package:very_good_slide_puzzle/movement/bloc/movement_cubit.dart';

const _triggerMovementDegrees = 5;

extension T on Tilt {
  Movement get movementDirection {
    final absXDeg = xDegrees.abs();
    final absYDeg = yDegrees.abs();
    if (absXDeg < _triggerMovementDegrees && absYDeg < _triggerMovementDegrees) {
      return Movement.none;
    }
    if (absXDeg > absYDeg) {
      return xRadian.isNegative ? Movement.up : Movement.down;
    } else {
      return yRadian.isNegative ? Movement.left : Movement.right;
    }
  }
}
