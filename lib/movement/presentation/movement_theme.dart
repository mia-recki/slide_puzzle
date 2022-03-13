import 'package:very_good_slide_puzzle/layout/layout.dart';
import 'package:very_good_slide_puzzle/movement/presentation/movement_layout_delegate.dart';
import 'package:very_good_slide_puzzle/simple/simple_theme.dart';

class MovementTheme extends SimpleTheme {
  const MovementTheme() : super();

  @override
  String get name => 'Movement';

  @override
  PuzzleLayoutDelegate get layoutDelegate => const MovementLayoutDelegate();
}
