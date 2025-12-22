part of 'level_complete_view.dart';

mixin _LevelCompleteViewMixin on StatelessWidget {
  void backButton(BuildContext context) {
    context.read<GameCubit>().reset();
    context.go(RouterPath.home.path);
  }

  void retryOnTap(BuildContext context, GameState state) {
    int buttonCount = state.whichLevelButton;
    context.read<GameCubit>().reset();
    context.read<GameCubit>().setLevelButton(buttonCount);
    context.go(RouterPath.game.path, extra: buttonCount);
  }

  void nextLevelOnTap(BuildContext context, GameState state) {
    int buttonCount = state.whichLevelButton;

    switch (buttonCount) {
      case 5:
        buttonCount = 10;
        context.read<GameCubit>().reset();
        context.go(RouterPath.game.path, extra: buttonCount);
        break;
      case 10:
        buttonCount = 12;
        context.read<GameCubit>().reset();
        context.go(RouterPath.game.path, extra: buttonCount);
        break;
      case 12:
        buttonCount = 15;
        context.read<GameCubit>().reset();

        context.go(RouterPath.game.path, extra: buttonCount);
        break;
      default:
        context.read<GameCubit>().reset();
        context.read<SelectLevelCubit>().choiceButtonColor();
        context.go(RouterPath.selectLevel.path);
        break;
    }
  }
}
