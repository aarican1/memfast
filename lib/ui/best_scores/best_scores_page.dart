import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/data/models/user_model.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/best_scores/best_scores_state.dart';

import 'package:memfast/ui/home/cubit/home_cubit.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';

import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/core/product/constants/media_query_constants.dart';
import 'package:memfast/core/product/widgets/circular_progress_indicator.dart';

class BestScoresPage extends StatelessWidget {
  const BestScoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryConstants mediaQCons = MediaQueryConstants(context: context);
    return BaseContainer(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_sharp,
              color: ColorConstants.textColor,
            ),
          ),
          toolbarHeight: kToolbarHeight,
          centerTitle: true,
          title: BaseTextWidget(text: LocaleKeys.bestPlayers.tr()),
        ),
        body: BlocListener<HomeCubit, BestScoresState>(
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: SizedBox(
                  width:
                      mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.width,
                      ) *
                      0.907,
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
                      height:
                          mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.height,
                          ) *
                          0.5,
                      child: BestScoreLWB(mediaQCons: mediaQCons),
                    ),
                  );
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Center(
                  child: BaseTextWidget(text: LocaleKeys.yourScore.tr()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: SizedBox(
                  width:
                      mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.width,
                      ) *
                      0.907,
                  height: 10,
                  child: CustomPaint(painter: MyLinePainter()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: PersonalRank(mediaQCons: mediaQCons),
              ),
              const SizedBox(height: kToolbarHeight),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalRank extends StatelessWidget {
  const PersonalRank({super.key, required this.mediaQCons});

  final MediaQueryConstants mediaQCons;

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
                      BaseTextWidget(text: LocaleKeys.rank.tr()),
                      BaseTextWidget(text: '${personalIndex + 1}'),
                    ],
                  ),
                  Column(
                    children: [
                      BaseTextWidget(text: LocaleKeys.score.tr()),
                      BaseTextWidget(
                        text: '${personalRank?.score ?? LocaleKeys.score.tr()}',
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

class BestScoreLWB extends StatelessWidget {
  const BestScoreLWB({super.key, required this.mediaQCons});

  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BestScoresState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.bestScore?.length ?? 0,
          itemBuilder: (context, index) {
            late final bestscorer = state.bestScore?[index];
            return SizedBox(
              width:
                  mediaQCons.getContantsMediaQueryData(
                    MediaQueryContantsEnum.width,
                  ) *
                  0.934,
              height:
                  mediaQCons.getContantsMediaQueryData(
                    MediaQueryContantsEnum.height,
                  ) *
                  0.0450 *
                  2,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom:
                      mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.height,
                      ) *
                      0.016,
                ),
                child: ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(
                      left: mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.nameFontSize,
                      ),
                    ),
                    child: BaseTextWidget(text: '${index + 1}.'),
                  ),
                  title: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.nameFontSize,
                          ),
                        ),
                        child: BaseTextWidget(
                          text:
                              bestscorer?.username ??
                              LocaleKeys.playerName.tr(),
                        ),
                      ),
                      BaseTextWidget(text: '${bestscorer?.score}'),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
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
