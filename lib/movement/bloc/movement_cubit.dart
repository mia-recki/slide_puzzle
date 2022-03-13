import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tilt/tilt.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/movement/bloc/movement_state.dart';
import 'package:very_good_slide_puzzle/movement/bloc/tilt_helper.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

part 'puzzle_helper.dart';

enum Movement { up, down, left, right, none }

class MovementCubit extends Cubit<MovementState> {
  MovementCubit(this._puzzleBloc) : super(MovementState.initial()) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    DeviceTilt().stream.listen((tilt) {
      final direction = tilt.movementDirection;
      final movementCandidate = _puzzleBloc.state.puzzle.movableTile(direction);
      final s = state.copyWith(tilt, movementCandidate);

      if (_shouldSwap(s)) {
        _puzzleBloc.add(TileTapped(movementCandidate!));
        HapticFeedback.heavyImpact();
        emit(s.swap(s.tilt.movementDirection));
      } else {
        emit(s);
      }
    });
  }
  final PuzzleBloc _puzzleBloc;

  bool _shouldSwap(MovementState currentState) {
    if (currentState.movementCandidate == null) {
      return false;
    }

    final direction = currentState.tilt.movementDirection;

    final previousMovementsInTheSameDirection =
        currentState.swapHistory.reversed.takeWhile((value) => value == direction);

    var requiredTilt = tiltTriggerDegrees;
    for (var i = 0; i < previousMovementsInTheSameDirection.length; i++) {
      requiredTilt += requiredTilt / 3 * 2;
    }

    late final double currentTilt;

    switch (direction) {
      case Movement.up:
      case Movement.down:
        currentTilt = currentState.tilt.xDegrees.abs();
        break;
      case Movement.left:
      case Movement.right:
        currentTilt = currentState.tilt.yDegrees.abs();
        break;
      case Movement.none:
        return false;
    }

    if (currentTilt > requiredTilt * 0.9) {
      HapticFeedback.lightImpact();
    }

    return currentTilt > requiredTilt;
  }
}
