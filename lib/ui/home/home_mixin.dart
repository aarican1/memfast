part of 'home_view.dart';

mixin HomeMixin on State<HomeView> {
  void listener(BuildContext context, BestScoresState state) {
    if (state.errorMessage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SomethingWentWrongDialog(
            errorMessage: state.errorMessage ?? '',
          );
        },
      );
      context.read<HomeCubit>().errorMakeNull();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() async {
        if (mounted) {
          await context.read<GoogleAdsCubit>().loadAd();
        }
      });
    });
  }
}
