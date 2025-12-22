import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/network_change/bloc/network_change_cubit.dart';
import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/ui/splash/bloc/cubit/splash_cubit.dart';
import 'package:memfast/ui/splash/bloc/state/splash_state.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
part 'splash_mixin.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> with SplashMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() async {
        if (mounted) {
          await context.read<SettingsCubit>().fetchAllows();

          if (mounted) {
            await context.read<NetworkChangeCubit>().fetchFirstResults();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: listener,
      child: const MySplashContainer(),
    );
  }
}

class MySplashContainer extends StatelessWidget {
  const MySplashContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorConstants.backgroundGradient,
      ),
      child: Scaffold(
        body: Center(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(
                LocaleKeys.memfast.tr(),
                duration: const Duration(seconds: 8),
                textStyle: context.textTheme.displayMedium?.copyWith(
                  color: ColorConstants.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
