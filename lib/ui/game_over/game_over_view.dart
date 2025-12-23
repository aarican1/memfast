import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/gen/assets.gen.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';
import 'package:memfast/google_ads/google_ads_state.dart';
import 'package:memfast/ui/game/game_cubit.dart';
import 'package:memfast/ui/game/game_state.dart';
import 'package:memfast/ui/game_over/widget/animation_down_arrow_widget.dart';
import 'package:memfast/ui/game_over/widget/sad_face_widget.dart';
import 'package:memfast/ui/sign_up/widgets/register_widgets.dart';
import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:memfast/generated/locale_keys.g.dart';

import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
part 'game_over_mixin.dart';

class GameOverView extends StatefulWidget {
  const GameOverView({super.key});

  @override
  State<GameOverView> createState() => _GameOverViewState();
}

class _GameOverViewState extends State<GameOverView> with GameOverMixin {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop || isNavigating) {
            return;
          }
          Future.microtask(() {
            if (context.mounted) {
              context.go(RouterPath.home.path);
              context.read<GameCubit>().reset();
            }
          });
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => backButtonOnPressed(context),
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: ColorConstants.textColor,
              ),
            ),
            toolbarHeight: kToolbarHeight,
            centerTitle: true,
            title: const RegisterAppBarTitle(),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: SizeConstants.twentyFour,
              horizontal: SizeConstants.sixteen,
            ),
            child: BlocListener<GoogleAdsCubit, GoogleAdsState>(
              listener: (context, state) => gameAdsListener(context, state),
              child: BlocBuilder<GameCubit, GameState>(
                builder: (context, state) {
                  return Column(
                    spacing: SizeConstants.thirtySix,
                    children: [
                      Center(
                        child: Text(
                          LocaleKeys.gameOver.tr(),
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: ColorConstants.textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SadFaceWidget(),
                      BlocSelector<GameCubit, GameState, bool>(
                        selector: (state) {
                          if (state.wrongNumber) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          return Text(
                            state
                                ? LocaleKeys.wrongNumber.tr()
                                : LocaleKeys.timeIsOver.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: ColorConstants.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        },
                      ),
                      Text(
                        '${LocaleKeys.yourScore.tr()}    ${state.score}',
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: ColorConstants.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: SizeConstants.fortyEight),

                      Row(
                        spacing: SizeConstants.sixteen,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BlocListener<GoogleAdsCubit, GoogleAdsState>(
                            listener: (context, state) {
                              if (state.rewardedAdLimit == true ||
                                  context
                                          .read<GameCubit>()
                                          .getIsOneGameOneAd() ==
                                      true) {
                                isOneGameOneAd = true;
                              }
                            },
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(
                                    LocaleKeys.legendsNeverGiveUp,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: ColorConstants.textColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ).tr(),
                                  Text(
                                    LocaleKeys.gainTimeAndContinue,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: ColorConstants.textColor,
                                        ),
                                  ).tr(),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: AnimatedDownArrow(),
                                  ),
                                  const SizedBox(height: SizeConstants.eight),

                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap:
                                        isOneGameOneAd
                                            ? null
                                            : () => watchRewarededAdsOnTap(
                                              context,
                                              state,
                                            ),
                                    child: Container(
                                      height: SizeConstants.fiftySix,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color:
                                            ColorConstants
                                                .buttonBackgroundColor,
                                        borderRadius: BorderRadius.circular(
                                          SizeConstants.twentyFour,
                                        ),
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
                                            duration:
                                                DurationConstants.durationLow,
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
                                                if (state.rewardedAdLimit ==
                                                        true ||
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
                                                                Assets
                                                                    .icons
                                                                    .videoAds,
                                                                height:
                                                                    SizeConstants
                                                                        .fortyFour,
                                                              ),
                                                              Text(
                                                                LocaleKeys
                                                                    .resume,
                                                                style: context
                                                                    .textTheme
                                                                    .bodyLarge
                                                                    ?.copyWith(
                                                                      color:
                                                                          ColorConstants
                                                                              .textColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                              ).tr(),
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
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () => reTryOnTap(context, state),
                              child: Container(
                                height: SizeConstants.fiftySix,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConstants.buttonBackgroundColor,
                                  borderRadius: BorderRadius.circular(
                                    SizeConstants.twentyFour,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    SizeConstants.eight,
                                  ),
                                  child: Center(
                                    child:
                                        Text(
                                          LocaleKeys.retry,
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                color: ColorConstants.textColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ).tr(),
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
      ),
    );
  }
}
