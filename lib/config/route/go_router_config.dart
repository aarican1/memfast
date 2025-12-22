import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/ui/best_scores/best_scores_view.dart';
import 'package:memfast/ui/game/game_view.dart';
import 'package:memfast/ui/game_over/game_over_view.dart';
import 'package:memfast/ui/home/home_view.dart';
import 'package:memfast/ui/how_to_play/how_to_play_view.dart';
import 'package:memfast/ui/level_complete/level_complete_view.dart';
import 'package:memfast/ui/select_level/select_level_view.dart';
import 'package:memfast/ui/settings/settings_view.dart';
import 'package:memfast/ui/sign_up/sign_up_view.dart';

import 'package:memfast/ui/splash/splash_view.dart';

class GoRouterConfig {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouterPath.splash.path,
    routes: [
      GoRoute(
        path: RouterPath.splash.path,
        name: RouterPath.splash.name,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RouterPath.home.path,
        name: RouterPath.home.name,
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: RouterPath.signUp.path,
        name: RouterPath.signUp.name,
        builder: (context, state) => const SignUpView(),
      ),
      GoRoute(
        path: RouterPath.selectLevel.path,
        name: RouterPath.selectLevel.name,
        builder: (context, state) => const SelectLevelView(),
      ),

      GoRoute(
        path: RouterPath.settings.path,
        name: RouterPath.settings.name,
        builder: (context, state) => const SettingsView(),
      ),

      GoRoute(
        path: RouterPath.game.path,
        name: RouterPath.game.name,
        builder: (context, state) => const GameView(),
      ),
      GoRoute(
        path: RouterPath.levelComplete.path,
        name: RouterPath.levelComplete.name,
        builder: (context, state) => const LevelCompleteView(),
      ),

      GoRoute(
        path: RouterPath.gameOver.path,
        name: RouterPath.gameOver.name,
        builder: (context, state) => const GameOverView(),
      ),
      GoRoute(
        path: RouterPath.bestScores.path,
        name: RouterPath.bestScores.name,
        builder: (context, state) => const BestScoresView(),
      ),
      GoRoute(
        path: RouterPath.howToPlay.path,
        name: RouterPath.howToPlay.name,
        builder: (context, state) => const HowToPlayView(),
      ),
    ],
  );
}
