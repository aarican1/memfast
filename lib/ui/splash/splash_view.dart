import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/home/home_view.dart';
import 'package:memfast/ui/network_change/bloc/network_change_cubit.dart';

import 'package:memfast/ui/register/register_view.dart';
import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/ui/splash/bloc/cubit/splash_cubit.dart';
import 'package:memfast/ui/splash/bloc/state/splash_state.dart';
import 'package:memfast/core/product/constants/color_contants.dart';

import 'package:memfast/core/utility/enums/firebase_enums.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future(() async {
        if (mounted) {
          mounted ? await context.read<SettingsCubit>().fetchAllows() : null;
          mounted
              ? await context.read<NetworkChangeCubit>().fetchFirstResults()
              : null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return !(state.isLogIn ??
                          false) // splash Cubitte false atamasi yapildi
                      ? const HomeView()
                      : RegisterView(
                        userReferences:
                            MyFirebaseCollectionEnum.users.references,
                      );
                },
              ),
            );
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
      },
      child: const MySplashContainer(),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
