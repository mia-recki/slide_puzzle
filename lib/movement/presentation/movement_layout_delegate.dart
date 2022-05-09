import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/movement/bloc/movement_cubit.dart';
import 'package:very_good_slide_puzzle/puzzle/bloc/puzzle_bloc.dart';
import 'package:very_good_slide_puzzle/simple/simple_puzzle_layout_delegate.dart';

class MovementLayoutDelegate extends SimplePuzzleLayoutDelegate {
  const MovementLayoutDelegate();

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final movementState = context.select((MovementCubit cubit) => cubit.state);
        final movementCandidate = movementState.movementCandidate;
        // if this tile is not elegible for movement, return the original view
        if (movementCandidate == null || movementCandidate.currentPosition != tile.currentPosition) {
          return super.tileBuilder(tile, state);
        }
        // Offset the position of the movement candidate tile in a given direction
        final halfTile = constraints.maxWidth / 2;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.slowMiddle,
          transform: Matrix4.translationValues(
            movementState.yTilt * halfTile,
            movementState.xTilt * halfTile,
            0,
          ),
          child: super.tileBuilder(tile, state),
        );
      },
    );
  }
}
