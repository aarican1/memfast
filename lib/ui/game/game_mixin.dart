part of 'game_view.dart';

mixin GameMixin on State<GameView> {
  late List<Offset> buttonOffsetList;
  late int buttonCount;

  void setList(BuildContext context, int widgetCount) {
    buttonOffsetList = generateRandomButtonOffset(context, widgetCount, 96, 96);
  }

  Future<void> listener(BuildContext context, GameState state) async {
    if (state.errorMessage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SomethingWentWrongDialog(
            errorMessage: state.errorMessage ?? '',
          );
        },
      );
      context.read<GameCubit>().errorMakeNull();
    }

    if (state.scoreCalculated == true && state.isGameDone == true) {
      if (state.timeisOver || state.wrongNumber) {
        context.push(RouterPath.gameOver.path, extra: buttonCount);
        context.read<GameCubit>().setGameDone(false);
      } else {
        context.push(RouterPath.levelComplete.path, extra: buttonCount);
        context.read<GameCubit>().setGameDone(false);
      }
      return;
    }

    if (state.scoreCalculated == false) {
      if (state.timeisOver == true || state.wrongNumber == true) {
        await context.read<GameCubit>().calculateScore(
          false,
          buttonCount,
          state.timerCount,
        );
      } else if (state.buttonTapCounter == buttonCount + 1) {
        await context.read<GameCubit>().calculateScore(
          true,
          buttonCount,
          state.timerCount,
        );
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChange");
    buttonCount = GoRouter.of(context).state.extra as int;
    setList(context, buttonCount);
    context.read<GameCubit>().setLevelButton(buttonCount);
  }

  @override
  void didUpdateWidget(covariant GameView oldWidget) {
    super.didUpdateWidget(oldWidget);
    buttonCount = GoRouter.of(context).state.extra as int;
    setList(context, buttonCount);
    context.read<GameCubit>().setLevelButton(buttonCount);
  }

  @override
  void initState() {
    super.initState();
    buttonCount = GoRouter.of(context).state.extra as int;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
