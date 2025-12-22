import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/core/product/widgets/circular_progress_indicator.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/data/models/user_model.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/best_scores/best_scores_state.dart';
import 'package:memfast/ui/home/cubit/home_cubit.dart';

class PersonalRankWidget extends StatelessWidget {
  const PersonalRankWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BestScoresState>(
      builder: (context, state) {
        int personalIndex = state.personalIndex;
        if (personalIndex == -1) {
          context.read<HomeCubit>().isReadBlock();
        }

        UserModel? personalRank = state.rankList?[personalIndex];

        return BlocSelector<HomeCubit, BestScoresState, bool>(
          selector: (state) {
            return state.isUserReaded ?? false;
          },
          builder: (context, state) {
            return AnimatedCrossFade(
              duration: DurationConstants.duration,
              crossFadeState:
                  state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              secondChild: const CenterCircularIndicator(),
              firstChild: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        LocaleKeys.rank.tr(),
                        style: context.textTheme.titleLarge?.copyWith(
                          color: ColorConstants.textColor,
                        ),
                      ),
                      Text(
                        '${personalIndex + 1}',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: ColorConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        LocaleKeys.score.tr(),
                        style: context.textTheme.titleLarge?.copyWith(
                          color: ColorConstants.textColor,
                        ),
                      ),
                      Text(
                        '${personalRank?.score ?? LocaleKeys.score.tr()}',
                        style: context.textTheme.titleLarge?.copyWith(
                          color: ColorConstants.textColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
