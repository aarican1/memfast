part of 'splash_view.dart';

mixin SplashMixin on State<SplashView> {
  void listener(BuildContext context, SplashState state) {
    if (state.errorMessage != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SomethingWentWrongDialog(
            errorMessage: state.errorMessage ?? '',
          );
        },
      );
    }
    if (state.isVersionOk == true && state.isFirabaseOk == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (state.isLogIn ?? false) {
          context.go(RouterPath.home.path);
        } else {
          context.go(RouterPath.signUp.path);
        }
      });
    }
    if (state.isFirabaseOk == true && state.isVersionOk == false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyUpdateAlertDialog(url: state.updateUri);
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() async {
        if (mounted) {
          await context.read<SettingsCubit>().fetchAllows();
        }
        if (mounted) {
          await context.read<NetworkChangeCubit>().fetchFirstResults();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
