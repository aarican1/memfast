import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';
import 'package:memfast/google_ads/google_ads_error_alert.dart';
import 'package:memfast/google_ads/google_ads_state.dart';
import 'package:memfast/pages/game/game_cubit.dart';
import 'package:memfast/pages/game/game_page.dart';
import 'package:memfast/pages/game/game_state.dart';
import 'package:memfast/pages/home/page/home_page.dart';
import 'package:memfast/pages/register/widgets/register_widgets.dart';
import 'package:memfast/pages/settings/settings_cubit.dart';

import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/duration_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';

// ignore: must_be_immutable
class GameOverPage extends StatelessWidget {
  GameOverPage({
    super.key,
    required this.mediaQCons,
  });
  final MediaQueryConstants mediaQCons;
  bool isOneGameOneAd = false;
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          context.read<GameCubit>().reset();
          context.read<GameCubit>().dispose();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const HomePage()));
        },
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    context.read<GameCubit>().reset();
                    context.read<GameCubit>().dispose();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: ColorConstants.textColor,
                  )),
              toolbarHeight: MediaQueryConstants(context: context)
                      .getContantsMediaQueryData(
                          MediaQueryContantsEnum.appbarPadding) *
                  2,
              centerTitle: true,
              title: Padding(
                padding: EdgeInsets.only(
                    top: MediaQueryConstants(context: context)
                        .getContantsMediaQueryData(
                            MediaQueryContantsEnum.appbarPadding)),
                child: RegisterAppBarTitle(
                    appBarFontSize: MediaQueryConstants(context: context)
                        .getContantsMediaQueryData(
                            MediaQueryContantsEnum.appBarFontSize),
                    titleAppbarColor: ColorConstants.textColor),
              )),
          body: BlocListener<GoogleAdsCubit, GoogleAdsState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return GoogleAdsErrorAlert(
                          errorMessage: state.errorMessage ?? '');
                    });
              }
            },
            child: BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.appBarFontSize),
                          textColor: ColorConstants.textColor,
                          text: 'GAME OVER'),
                    ),
                    BlocSelector<GameCubit, GameState, bool>(
                      selector: (state) {
                        if (state.wrongNumber) {
                          return true;
                        } else {
                          return false;
                        }
                      },
                      builder: (context, state) {
                        return BaseTextWidget(
                            fontSize: mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.usernameFontSize),
                            textColor: ColorConstants.textColor,
                            text: state
                                ? StringConstants.wrongNumber
                                : StringConstants.timeisOver);
                      },
                    ),
                    BaseTextWidget(
                        fontSize: mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.usernameFontSize),
                        textColor: ColorConstants.textColor,
                        text: '${StringConstants.yourScore}    ${state.score}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocListener<GoogleAdsCubit, GoogleAdsState>(
                          listener: (context, state) {
                            if (state.rewardedAdLimit == true ||
                                context.read<GameCubit>().getIsOneGameOneAd() ==
                                    true) {
                              isOneGameOneAd = true;
                            }
                          },
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: isOneGameOneAd
                                ? null
                                : () {
                                    context.read<GoogleAdsCubit>().getLoadedInfo()
                                        ? context
                                            .read<SettingsCubit>()
                                            .stopMusic()
                                        : null;
                                    context.read<GoogleAdsCubit>().showAd(
                                        onAdDismissedFullScreenContent: (p0) {
                                      bool rewareded = context
                                          .read<GoogleAdsCubit>()
                                          .getReward();

                                      if (rewareded) {
                                        int buttonCount = state.whichLevelButton;
                                        context.read<GameCubit>().resume(
                                            buttonCount,
                                            state.score,
                                            state.buttonTapCounter,
                                            state.buttonVisibiltyList);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => GamePage(
                                                      buttonCount: buttonCount,
                                                    )));
                                        context.read<GoogleAdsCubit>().loadAd();
                                      } else {}
                                    }, onUserEarnedReward: (p0, p1) {
                                      context.read<GoogleAdsCubit>().winReward();
                                    });
                                  },
                            child: Container(
                              height: mediaQCons.getContantsMediaQueryData(
                                      MediaQueryContantsEnum.height) *
                                  0.064,
                              width: mediaQCons.getContantsMediaQueryData(
                                      MediaQueryContantsEnum.width) *
                                  0.418,
                              decoration: BoxDecoration(
                                color: ColorConstants.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                    mediaQCons.getContantsMediaQueryData(
                                            MediaQueryContantsEnum.height) *
                                        0.064 *
                                        0.366),
                              ),
                              child: BlocSelector<GoogleAdsCubit, GoogleAdsState,
                                  bool>(
                                selector: (state) {
                                  return state.adLoading ?? false;
                                },
                                builder: (context, state) {
                                  return AnimatedCrossFade(
                                    duration: DurationConstants.durationLow,
                                    crossFadeState: state
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    secondChild: const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorConstants.textColor,
                                      ),
                                    ),
                                    firstChild: BlocSelector<GoogleAdsCubit,
                                        GoogleAdsState, bool>(
                                      selector: (state) {
                                        if (state.rewardedAdLimit == true ||
                                            context
                                                    .read<GameCubit>()
                                                    .getIsOneGameOneAd() ==
                                                true) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      },
                                      builder: (context, state) {
                                        return Center(
                                          child: state
                                              ? BaseTextWidget(
                                                  fontSize: mediaQCons
                                                          .getContantsMediaQueryData(
                                                              MediaQueryContantsEnum
                                                                  .height) *
                                                      0.017,
                                                  textColor:
                                                      ColorConstants.textColor,
                                                  text:
                                                      StringConstants.rewardLimit)
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Lottie.asset(
                                                        'lib/assets/icons/videoAds.json',
                                                        height: mediaQCons
                                                                .getContantsMediaQueryData(
                                                                    MediaQueryContantsEnum
                                                                        .height) *
                                                            0.064),
                                                    BaseTextWidget(
                                                        fontSize: mediaQCons
                                                                .getContantsMediaQueryData(
                                                                    MediaQueryContantsEnum
                                                                        .height) *
                                                            0.023,
                                                        textColor: ColorConstants
                                                            .textColor,
                                                        text: StringConstants
                                                            .resume),
                                                  ],
                                                ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            int buttonCount = state.whichLevelButton;
                            context.read<GameCubit>().reset();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GamePage(
                                          buttonCount: buttonCount,
                                        )));
                          },
                          child: Container(
                            height: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.height) *
                                0.064,
                            width: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.302,
                            decoration: BoxDecoration(
                              color: ColorConstants.buttonBackgroundColor,
                              borderRadius: BorderRadius.circular(
                                  mediaQCons.getContantsMediaQueryData(
                                          MediaQueryContantsEnum.height) *
                                      0.064 *
                                      0.366),
                            ),
                            child: Center(
                              child: BaseTextWidget(
                                  fontSize: mediaQCons.getContantsMediaQueryData(
                                          MediaQueryContantsEnum.height) *
                                      0.023,
                                  textColor: ColorConstants.textColor,
                                  text: StringConstants.retry),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
