import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/size_extension.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/best_scores/best_scores_state.dart';
import 'package:memfast/ui/best_scores/widget/best_score_lwb.dart';
import 'package:memfast/ui/best_scores/widget/personal_rank_widget.dart';
import 'package:memfast/ui/home/cubit/home_cubit.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/core/product/widgets/circular_progress_indicator.dart';

class BestScoresView extends StatelessWidget {
  const BestScoresView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: ColorConstants.textColor,
            ),
          ),
          toolbarHeight: kToolbarHeight,
          centerTitle: true,
          title: Text(
            LocaleKeys.bestPlayers.tr(),
            style: context.textTheme.headlineSmall?.copyWith(
              color: ColorConstants.textColor,
            ),
          ),
        ),
        body: BlocConsumer<HomeCubit, BestScoresState>(
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
              context.read<HomeCubit>().errorMakeNull();
            }
          },
          builder:
              (context, state) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 12),
                    child: SizedBox(
                      width: double.infinity,
                      height: 10,
                      child: CustomPaint(painter: MyLinePainter()),
                    ),
                  ),
                  BlocSelector<HomeCubit, BestScoresState, bool>(
                    selector: (state) {
                      return state.isloading ?? false;
                    },
                    builder: (context, state) {
                      return AnimatedCrossFade(
                        duration: DurationConstants.duration,
                        crossFadeState:
                            state
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                        secondChild: const CenterCircularIndicator(),
                        firstChild: SizedBox(
                          height: context.dynamicHeigth(0.4),
                          child: const BestScoreLWB(),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: Column(
                        spacing: SizeConstants.four,
                        children: [
                          Text(
                            " ${LocaleKeys.playerName.tr()}: ${state.playerName}",
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: ColorConstants.textColor,
                            ),
                          ),
                          Text(
                            LocaleKeys.yourScore.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: ColorConstants.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: SizeConstants.twelve,
                      child: CustomPaint(painter: MyLinePainter()),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: PersonalRankWidget(),
                  ),
                  const SizedBox(height: kToolbarHeight),
                ],
              ),
        ),
      ),
    );
  }
}

class MyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = ColorConstants.textColor
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 1.0;

    final double centerY = size.height / 2;
    final Offset startPoint = Offset(0, centerY);
    final Offset endPoint = Offset(size.width, centerY);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
