import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';

import 'package:memfast/initializae/start_game.dart';
import 'package:memfast/pages/game/game_cubit.dart';

import 'package:memfast/pages/home/cubit/home_cubit.dart';
import 'package:memfast/pages/network_change/bloc/network_change_cubit.dart';
import 'package:memfast/pages/network_change/bloc/network_change_state.dart';

import 'package:memfast/pages/register/bloc/register_cubit.dart';

import 'package:memfast/pages/select_level/cubit/select_level_cubit.dart';

import 'package:memfast/pages/settings/settings_cubit.dart';

import 'package:memfast/pages/splash/bloc/cubit/splash_cubit.dart';
import 'package:memfast/pages/splash/splash_page.dart';

import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/duration_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';

import 'package:memfast/services/network_change_manage/network_change_enum_extensions.dart';

Future<void> main() async { 
  await StartGame.init();
  runApp(const MyApp());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GoogleAdsCubit>(
            create: (context) => GoogleAdsCubit(),
          ),
          BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
          BlocProvider<SplashCubit>(
            create: (context) => SplashCubit(),
          ),
          BlocProvider<RegisterCubit>(
            create: (context) => RegisterCubit(),
          ),
          BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
          BlocProvider<SelectLevelCubit>(create: (context) => SelectLevelCubit()),
          BlocProvider<GameCubit>(
            create: (context) => GameCubit(),
          ),
          BlocProvider<NetworkChangeCubit>(
            create: (context) => NetworkChangeCubit(),
          )
        ],
        child: MaterialApp(
            title: 'Memfast',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.transparent,
              appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
              textTheme: GoogleFonts.novaSquareTextTheme(),
              useMaterial3: true,
            ),
            builder: (context, child) {
              context.read<GoogleAdsCubit>().loadAd();
              context.read<SettingsCubit>().fetchAllows();

              return BlocSelector<NetworkChangeCubit, NetworkChangeState, bool>(
                selector: (state) {
                  if (state.networkChangeResults == NetworkChangeResults.off) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  MediaQueryConstants mediaQCons =
                      MediaQueryConstants(context: context);
                  return Column(
                    children: [
                      Expanded(child: child ?? const Placeholder()),
                      AnimatedCrossFade(
                          firstChild: Container(
                            height: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.height) *
                                0.075,
                            color: ColorConstants.colorList[1],
                            child: Center(
                                child: Lottie.asset(
                              'lib/assets/icons/internet.json',
                            )),
                          ),
                          secondChild: const SizedBox.shrink(),
                          crossFadeState: state
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: DurationConstants.duration),
                    ],
                  );
                },
              );
            },
            home: const SplashPage()));
  }
}
