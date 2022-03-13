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
        final halfTile = constraints.maxWidth / 2;
        final xTranslation = movementCandidate != tile ? 0.0 : movementState.yTilt * halfTile;
        final yTranslation = movementCandidate != tile ? 0.0 : movementState.xTilt * halfTile;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.slowMiddle,
          transform: Matrix4.translationValues(
            xTranslation,
            yTranslation,
            0,
          ),
          child: super.tileBuilder(tile, state),
        );
      },
    );
  }
}
