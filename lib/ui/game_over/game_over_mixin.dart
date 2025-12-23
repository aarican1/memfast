part of 'game_over_view.dart';

mixin GameOverMixin on State<GameOverView> {
  bool isOneGameOneAd = false;
  bool isNavigating = false;

  void reTryOnTap(BuildContext context, GameState state) {
    isNavigating = true;
    int buttonCount = state.whichLevelButton;
    context.read<GameCubit>().reset();
    context.go("${RouterPath.game.path}/$buttonCount");
  }

  Future<void> watchRewarededAdsOnTap(
    BuildContext context,
    GameState state,
  ) async {
    context.read<GoogleAdsCubit>().getLoadedInfo()
        ? context.read<SettingsCubit>().stopMusic()
        : null;
    context.read<GoogleAdsCubit>().showAd(
      onAdDismissedFullScreenContent: (p0) async {
        bool rewareded = context.read<GoogleAdsCubit>().getReward();

        if (rewareded) {
          isNavigating = true;
          int buttonCount = state.whichLevelButton;
          context.read<GameCubit>().resume(
            buttonCount,
            state.score,
            state.buttonTapCounter,
            state.buttonVisibiltyList,
          );
          context.go("${RouterPath.game.path}/$buttonCount");
          await context.read<GoogleAdsCubit>().loadAd();
        } else {}
      },
      onUserEarnedReward: (p0, p1) async {
        context.read<GoogleAdsCubit>().winReward();
      },
    );
  }

  void gameAdsListener(BuildContext context, GoogleAdsState state) {
    if (state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage ?? ""),
          backgroundColor: ColorConstants.buttonBackgroundColor,
        ),
      );
      context.read<GoogleAdsCubit>().errorMakeNull();
    }
  }

  void backButtonOnPressed(BuildContext context) {
    context.read<GameCubit>().reset();
    context.go(RouterPath.home.path);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() {
        if (mounted) {
          context.read<GoogleAdsCubit>().loadAd();
        }
      });
    });
  }
}
