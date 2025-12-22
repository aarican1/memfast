import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';
import 'package:memfast/ui/best_scores/best_scores_state.dart';

import 'package:memfast/ui/home/cubit/home_cubit.dart';
import 'package:memfast/ui/home/widgets/brain_animation.dart';
import 'package:memfast/ui/home/widgets/home_widgets.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';

import 'package:memfast/core/product/base_widgets/base_container_widget.dart';

part 'home_mixin.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getUserList();
    return BaseContainer(
      child: Scaffold(
        appBar: AppBar(
          leading: const SettingsButton(),
          actions: [const BestScoresButton()],
        ),
        body: BlocListener<HomeCubit, BestScoresState>(
          listener: listener,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: SizeConstants.twentyFour,
            children: [
              BrainAnimation(),
              Spacer(),
              NameText(),
              SizedBox(height: SizeConstants.sixteen),
              LetsStartButton(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
