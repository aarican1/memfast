import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/best_scores/best_scores_state.dart';

import 'package:memfast/pages/home/cubit/home_cubit.dart';
import 'package:memfast/pages/home/widgets/home_widgets.dart';
import 'package:memfast/pages/splash/alert_widget/alert_dialog.dart';

import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/constants/media_query_constants.dart';

//
///
////
////  BASE TEXT KULLAN UNUTMA
////
////
/////
////
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryConstants mediaQCons = MediaQueryConstants(context: context);
    context.read<HomeCubit>().getUserList();
    return BaseContainer(
        child: Scaffold(
            body: BlocListener<HomeCubit, BestScoresState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SomethingWentWrongDialog(
                    errorMessage: state.errorMessage ?? '');
              });
                context.read<HomeCubit>().errorMakeNull();
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SettingsButton(mediaQCons: mediaQCons),
              BestScoresButton(mediaQCons: mediaQCons),
            ],
          ),
          NameText(mediaQCons: mediaQCons),
          LetsStartButton(mediaQCons: mediaQCons)
        ],
      ),
    )
    )
    );
  }
}
