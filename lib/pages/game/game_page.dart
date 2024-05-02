import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:memfast/core/methods/generate_random_offset.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';

import 'package:memfast/pages/game/game_cubit.dart';
import 'package:memfast/pages/game/game_state.dart';
import 'package:memfast/pages/game_over/game_over_page.dart';
import 'package:memfast/pages/level_complete/level_complete_page.dart';
import 'package:memfast/pages/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/pages/settings/settings_cubit.dart';

import 'package:memfast/pages/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/duration_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.buttonCount,
  });

  final int buttonCount;
  static late List<Offset> buttonOffsetList;

  void setList(MediaQueryData mediaQueryData, int widgetCount) {
    buttonOffsetList = generateRandomButtonOffset(mediaQueryData, widgetCount,
        mediaQueryData.size.width * 0.11, mediaQueryData.size.width * 0.11);
  }

  @override
  Widget build(BuildContext context) {
    context.read<GoogleAdsCubit>().loadAd();
    context.read<GameCubit>().setLevelButton(buttonCount);
    setList(MediaQuery.of(context), buttonCount);
    return BaseContainer(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocConsumer<GameCubit, GameState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SomethingWentWrongDialog(
                            errorMessage: state.errorMessage ?? '');
                      });
                  context.read<GameCubit>().errorMakeNull();
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: BaseTextWidget(
                      fontSize: MediaQueryConstants(context: context)
                          .getContantsMediaQueryData(
                              MediaQueryContantsEnum.nameFontSize),
                      textColor: ColorConstants.textColor,
                      text: '00:${state.timerCount}'),
                );
              },
            )
          ],
          centerTitle: true,
          // muhtemel toolbarHeight bu
          // toolbarHeight: MediaQuery.of(context).size.height * 0.08,
          leading: IconButton(
              onPressed: () {
                context.read<SelectLevelCubit>().choiceButtonColor();

                context.read<GameCubit>().reset();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: ColorConstants.textColor,
              )),
          title: BaseTextWidget(
            fontSize: MediaQueryConstants(context: context)
                .getContantsMediaQueryData(MediaQueryContantsEnum.nameFontSize),
            textColor: ColorConstants.textColor,
            text: StringConstants.appName,
          ),
        ),
        body: PopScope(
          onPopInvoked: (didPop) {
            context.read<SelectLevelCubit>().choiceButtonColor();
            context.read<GameCubit>().reset();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomMultiChildLayout(
                  delegate: CustomMultiChildLayoutDelegate(
                      mediaQueryData: MediaQuery.of(context),
                      widgetCount: buttonCount),
                  children: buildButtonWidget(
                    MediaQuery.of(context),
                    buttonCount,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  CustomMultiChildLayoutDelegate(
      {required this.mediaQueryData, required this.widgetCount});
  MediaQueryData mediaQueryData;
  int widgetCount;

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }

  @override
  void performLayout(Size size) {
    for (int i = 0; i < widgetCount; i++) {
      if (hasChild(i)) {
        layoutChild(i, BoxConstraints.loose(size * 0.2));
        positionChild(
            i,
            Offset(GamePage.buttonOffsetList[i].dx,
                GamePage.buttonOffsetList[i].dy));
      }
    }
  }
}

List<Widget> buildButtonWidget(
  MediaQueryData mediaQuery,
  int widgetCount,
) {
  double buttonSize = mediaQuery.size.width * 0.11;

  List<Widget> numberButtonList = [];
  for (int i = 0; i < widgetCount; i++) {
    numberButtonList.add(LayoutId(
      id: i,
      child: BlocConsumer<GameCubit, GameState>(
        listener: (context, state) async {
          if (state.scoreCalculated == false) {
            if (state.timeisOver == true || state.wrongNumber == true) {
              // düzeltme gerekebilir
              context
                  .read<GameCubit>()
                  .calculateScore(false, widgetCount, state.timerCount);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameOverPage(
                          mediaQCons: MediaQueryConstants(context: context))));
            }

            if (state.buttonTapCounter == widgetCount + 1) {
              context
                  .read<GameCubit>()
                  .calculateScore(true, widgetCount, state.timerCount);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LevelComplete(
                          mediaQCons: MediaQueryConstants(context: context))));
            }
          } else {}
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Visibility(
              visible: state.buttonVisibiltyList[i + 1],
              child: GestureDetector(
                onTap: () {
                  context.read<SettingsCubit>().manageSound();
                  // AudioManager().playSound();
                  if (i + 1 == 1) {
                    context.read<GameCubit>().firstTap(i + 1);
                  } else {
                    context.read<GameCubit>().buttonCounter(i + 1);
                  }
                },
                child: AnimatedCrossFade(
                  duration: DurationConstants.durationLow,
                  crossFadeState: state.isTapFirst
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  secondChild: Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.textColor,
                      borderRadius: BorderRadius.circular(buttonSize * 0.24),
                    ),
                    height: buttonSize,
                    width: buttonSize,
                  ),
                  firstChild: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(buttonSize * 0.24),
                          border: Border.all(width: 1, color: Colors.white)),
                      height: buttonSize,
                      width: buttonSize,
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style:
                              const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }

  return numberButtonList;
}
