import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/models/user_model.dart';
import 'package:memfast/pages/best_scores/best_scores_state.dart';

import 'package:memfast/pages/home/cubit/home_cubit.dart';
import 'package:memfast/pages/splash/alert_widget/alert_dialog.dart';

import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/duration_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';
import 'package:memfast/product/widgets/circular_progress_indicator.dart';

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
                  )),
              toolbarHeight: mediaQCons.getContantsMediaQueryData(
                      MediaQueryContantsEnum.appbarPadding) *
                  2,
              centerTitle: true,
              title: Padding(
                  padding: EdgeInsets.only(
                      top: mediaQCons.getContantsMediaQueryData(
                          MediaQueryContantsEnum.appbarPadding)),
                  child: BaseTextWidget(
                      fontSize: mediaQCons.getContantsMediaQueryData(
                          MediaQueryContantsEnum.appBarFontSize),
                      textColor: ColorConstants.textColor,
                      text: StringConstants.appName)),
            ),
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.height) *
                              0.064),
                      child: Center(
                          child: BaseTextWidget(
                              fontSize: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.usernameFontSize),
                              textColor: ColorConstants.textColor,
                              text: StringConstants.bestPlayers)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.height) *
                              0.024,
                          bottom: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.height) *
                              0.064),
                      child: SizedBox(
                        width: mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.width) *
                            0.907,
                        height: 10,
                        child: CustomPaint(
                          painter: MyLinePainter(),
                        ),
                      ),
                    ),
                    BlocSelector<HomeCubit, BestScoresState, bool>(
                      selector: (state) {
                        return state.isloading ?? false;
                      },
                      builder: (context, state) {
                        return AnimatedCrossFade(
                            duration: DurationConstants.duration,
                            crossFadeState: state
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            secondChild: const CenterCircularIndicator(),
                            firstChild: BestScoreLWB(mediaQCons: mediaQCons));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.height) *
                              0.064),
                      child: Center(
                          child: BaseTextWidget(
                              fontSize: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.usernameFontSize),
                              textColor: ColorConstants.textColor,
                              text: StringConstants.yourScore)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.height) *
                              0.024,
                          bottom: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.height) *
                              0.064),
                      child: SizedBox(
                        width: mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.width) *
                            0.907,
                        height: 10,
                        child: CustomPaint(
                          painter: MyLinePainter(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.width) *
                            0.203,
                      ),
                      child: PersonalRank(mediaQCons: mediaQCons),
                    )
                  ],
                ))));
  }
}

class PersonalRank extends StatelessWidget {
  const PersonalRank({
    super.key,
    required this.mediaQCons,
  });

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
                      BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.nameFontSize) *
                              0.7,
                          textColor: ColorConstants.textColor,
                          text: StringConstants.rank),
                      BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.nameFontSize),
                          textColor: ColorConstants.textColor,
                          text: '${personalIndex + 1}'),
                    ],
                  ),
                  Column(
                    children: [
                      BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.nameFontSize) *
                              0.7,
                          textColor: ColorConstants.textColor,
                          text: StringConstants.score),
                      BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.nameFontSize),
                          textColor: ColorConstants.textColor,
                          text:
                              '${personalRank?.score ?? StringConstants.score}'),
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
  const BestScoreLWB({
    super.key,
    required this.mediaQCons,
  });

  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BestScoresState>(
      builder: (context, state) {
        return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.bestScore?.length ?? 3,
            itemBuilder: (context, index) {
              late final bestscorer = state.bestScore?[index];
              return SizedBox(
                width: mediaQCons
                        .getContantsMediaQueryData(MediaQueryContantsEnum.width) *
                    0.934,
                height: mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.height) *
                    0.0450 *
                    2,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.height) *
                          0.016),
                  child: ListTile(
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.nameFontSize)),
                      child: BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.nameFontSize),
                          textColor: ColorConstants.textColor,
                          text: '${index + 1}.'),
                    ),
                    title: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.nameFontSize),
                          ),
                          child: BaseTextWidget(
                              fontSize: mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.nameFontSize),
                              textColor: ColorConstants.textColor,
                              text: bestscorer?.username ??
                                  StringConstants.playerName),
                        ),
                        BaseTextWidget(
                            fontSize: mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.nameFontSize),
                            textColor: ColorConstants.textColor,
                            text: '${bestscorer?.score}'),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

class MyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
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
