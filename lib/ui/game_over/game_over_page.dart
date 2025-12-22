import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';
import 'package:memfast/google_ads/google_ads_error_alert.dart';
import 'package:memfast/google_ads/google_ads_state.dart';
import 'package:memfast/ui/game/game_cubit.dart';
import 'package:memfast/ui/game/game_page.dart';
import 'package:memfast/ui/game/game_state.dart';
import 'package:memfast/ui/home/home_view.dart';
import 'package:memfast/ui/register/widgets/register_widgets.dart';
import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:memfast/generated/locale_keys.g.dart';

import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/core/product/constants/media_query_constants.dart';

// ignore: must_be_immutable
class GameOverPage extends StatelessWidget {
  GameOverPage({super.key, required this.mediaQCons});
  final MediaQueryConstants mediaQCons;
  bool isOneGameOneAd = false;
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          context.read<GameCubit>().reset();
          context.read<GameCubit>().dispose();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
          );
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<GameCubit>().reset();
                context.read<GameCubit>().dispose();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: ColorConstants.textColor,
              ),
            ),
            toolbarHeight:
                MediaQueryConstants(context: context).getContantsMediaQueryData(
                  MediaQueryContantsEnum.appbarPadding,
                ) *
                2,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(
                top: MediaQueryConstants(
                  context: context,
                ).getContantsMediaQueryData(
                  MediaQueryContantsEnum.appbarPadding,
                ),
              ),
              child: const RegisterAppBarTitle(),
            ),
          ),
          body: BlocListener<GoogleAdsCubit, GoogleAdsState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return GoogleAdsErrorAlert(
                      errorMessage: state.errorMessage ?? '',
                    );
                  },
                );
              }
            },
            child: BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: BaseTextWidget(text: LocaleKeys.gameOver.tr()),
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
                          text:
                              state
                                  ? LocaleKeys.wrongNumber.tr()
                                  : LocaleKeys.timeIsOver.tr(),
                        );
                      },
                    ),
                    BaseTextWidget(
                      text: '${LocaleKeys.yourScore.tr()}    ${state.score}',
                    ),
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
                            onTap:
                                isOneGameOneAd
                                    ? null
                                    : () {
                                      context
                                              .read<GoogleAdsCubit>()
                                              .getLoadedInfo()
                                          ? context
                                              .read<SettingsCubit>()
                                              .stopMusic()
                                          : null;
                                      context.read<GoogleAdsCubit>().showAd(
                                        onAdDismissedFullScreenContent: (p0) {
                                          bool rewareded =
                                              context
                                                  .read<GoogleAdsCubit>()
                                                  .getReward();

                                          if (rewareded) {
                                            int buttonCount =
                                                state.whichLevelButton;
                                            context.read<GameCubit>().resume(
                                              buttonCount,
                                              state.score,
                                              state.buttonTapCounter,
                                              state.buttonVisibiltyList,
                                            );
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) => GamePage(
                                                      buttonCount: buttonCount,
                                                    ),
                                              ),
                                            );
                                            context
                                                .read<GoogleAdsCubit>()
                                                .loadAd();
                                          } else {}
                                        },
                                        onUserEarnedReward: (p0, p1) {
                                          context
                                              .read<GoogleAdsCubit>()
                                              .winReward();
                                        },
                                      );
                                    },
                            child: Container(
                              height: 56,
                              width:
                                  mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width,
                                  ) *
                                  0.418,
                              decoration: BoxDecoration(
                                color: ColorConstants.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: BlocSelector<
                                GoogleAdsCubit,
                                GoogleAdsState,
                                bool
                              >(
                                selector: (state) {
                                  return state.adLoading ?? false;
                                },
                                builder: (context, state) {
                                  return AnimatedCrossFade(
                                    duration: DurationConstants.durationLow,
                                    crossFadeState:
                                        state
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
                                    secondChild: const Center(
                                      child: CircularProgressIndicator(
                                        color: ColorConstants.textColor,
                                      ),
                                    ),
                                    firstChild: BlocSelector<
                                      GoogleAdsCubit,
                                      GoogleAdsState,
                                      bool
                                    >(
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
                                          child:
                                              state
                                                  ? BaseTextWidget(
                                                    text:
                                                        LocaleKeys
                                                            .rewardLimitReached
                                                            .tr(),
                                                  )
                                                  : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Lottie.asset(
                                                        Assets.icons.videoAds,
                                                        height:
                                                            mediaQCons
                                                                .getContantsMediaQueryData(
                                                                  MediaQueryContantsEnum
                                                                      .height,
                                                                ) *
                                                            0.064,
                                                      ),
                                                      BaseTextWidget(
                                                        text:
                                                            LocaleKeys.resume
                                                                .tr(),
                                                      ),
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
                                builder:
                                    (context) =>
                                        GamePage(buttonCount: buttonCount),
                              ),
                            );
                          },
                          child: Container(
                            height: 56,
                            width:
                                mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.width,
                                ) *
                                0.302,
                            decoration: BoxDecoration(
                              color: ColorConstants.buttonBackgroundColor,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: BaseTextWidget(
                                  text: LocaleKeys.retry.tr(),
                                ),
                              ),
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
