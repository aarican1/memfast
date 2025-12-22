import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/best_scores/best_scores_state.dart';
import 'package:memfast/ui/home/cubit/home_cubit.dart';

class BestScoreLWB extends StatelessWidget {
  const BestScoreLWB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BestScoresState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.bestScore?.length ?? 0,

          itemBuilder: (context, index) {
            late final bestscorer = state.bestScore?[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: SizeConstants.eight),
              width: double.infinity,
              height: SizeConstants.thirtySix,
              child: ListTile(
                leading:
                    index == 0
                        ? Image.asset(
                          Assets.icons.award.path,
                          height: SizeConstants.twentyFour,
                          width: SizeConstants.twentyFour,
                          fit: BoxFit.cover,
                        )
                        : Text(
                          '${index + 1}.',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: ColorConstants.textColor,
                          ),
                        ),

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizeConstants.sixteen,
                      ),
                      child: Text(
                        bestscorer?.username ?? LocaleKeys.playerName.tr(),
                        style: context.textTheme.titleLarge?.copyWith(
                          color: ColorConstants.textColor,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${bestscorer?.score}',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: ColorConstants.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
