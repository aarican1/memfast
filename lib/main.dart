import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/config/language/supported_languages.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';

import 'package:memfast/config/initializae/start_game.dart';
import 'package:memfast/ui/game/game_cubit.dart';

import 'package:memfast/ui/home/cubit/home_cubit.dart';
import 'package:memfast/ui/network_change/bloc/network_change_cubit.dart';
import 'package:memfast/ui/network_change/bloc/network_change_state.dart';

import 'package:memfast/ui/register/bloc/register_cubit.dart';

import 'package:memfast/ui/select_level/cubit/select_level_cubit.dart';

import 'package:memfast/ui/settings/settings_cubit.dart';

import 'package:memfast/ui/splash/bloc/cubit/splash_cubit.dart';
import 'package:memfast/ui/splash/splash_view.dart';

import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';

import 'package:memfast/data/services/network_change_manage/network_change_enum_extensions.dart';
import 'package:memfast/core/utility/constants/custom_theme_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await StartGame.init();
  runApp(
    EasyLocalization(
      supportedLocales: SupportedLanguages().supportedLanguages,
      path: 'assets/translations',
      fallbackLocale: SupportedLanguages().getLocale('en'),
      child: const MyApp(),
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        title: LocaleKeys.memfast.tr(),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: CustomThemeData.theme,
        builder: (context, child) => networkMainBuilder(context, child),
        home: const SplashView(),
      ),
    );
  }
}

final providers = [
  BlocProvider<GoogleAdsCubit>(create: (context) => GoogleAdsCubit()),
  BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
  BlocProvider<SplashCubit>(create: (context) => SplashCubit()),
  BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
  BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
  BlocProvider<SelectLevelCubit>(create: (context) => SelectLevelCubit()),
  BlocProvider<GameCubit>(create: (context) => GameCubit()),
  BlocProvider<NetworkChangeCubit>(create: (context) => NetworkChangeCubit()),
];

Widget networkMainBuilder(BuildContext context, Widget? child) {
  return BlocSelector<NetworkChangeCubit, NetworkChangeState, bool>(
    selector: (state) {
      if (state.networkChangeResults == NetworkChangeResults.off) {
        return true;
      } else {
        return false;
      }
    },
    builder: (context, state) {
      return Column(
        children: [
          Expanded(child: child ?? const Placeholder()),
          AnimatedCrossFade(
            firstChild: Container(
              height: SizeConstants.seventyTwo,
              color: ColorConstants.colorList[1],
              child: Center(child: Lottie.asset(Assets.icons.internet)),
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState:
                state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: DurationConstants.duration,
          ),
        ],
      );
    },
  );
}
