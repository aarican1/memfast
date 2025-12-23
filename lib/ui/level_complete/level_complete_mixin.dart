part of 'level_complete_view.dart';

mixin _LevelCompleteViewMixin on State<LevelCompleteView> {
  bool isNavigating = false;

  void backButton(BuildContext context) {
    context.read<GameCubit>().reset();
    context.go(RouterPath.home.path);
  }

  void retryOnTap(BuildContext context, GameState state) {
    isNavigating = true;
    int buttonCount = state.whichLevelButton;
    context.read<GameCubit>().reset();
    context.read<GameCubit>().setLevelButton(buttonCount);
    context.go("${RouterPath.game.path}/$buttonCount");
  }

  void selectLevelOnTap(BuildContext context, GameState state) {
    isNavigating = true;
    context.read<SelectLevelCubit>().choiceButtonColor();
    context.go(RouterPath.selectLevel.path);
  }

  void nextLevelOnTap(BuildContext context, GameState state) {
    isNavigating = true;
    int buttonCount = state.whichLevelButton;
    int nextLevel = buttonCount;
    switch (buttonCount) {
      case 5:
        nextLevel = 10;
        break;
      case 10:
        nextLevel = 12;
        break;
      case 12:
        nextLevel = 15;
        break;
      default:
        context.read<SelectLevelCubit>().choiceButtonColor();
        context.go(RouterPath.selectLevel.path);
        break;
    }
    context.read<GameCubit>().reset();
    context.go("${RouterPath.game.path}/$nextLevel");
  }
}
