import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/methods/generate_random_offset.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/size_extension.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/game/game_cubit.dart';
import 'package:memfast/ui/game/game_state.dart';
import 'package:memfast/ui/game/widget/thinking_brain_widget.dart';
import 'package:memfast/ui/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
part 'game_mixin.dart';

class GameView extends StatefulWidget {
  const GameView({super.key, required this.buttonCount});
  final int buttonCount;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> with GameMixin {
  @override
  Widget build(BuildContext context) {
    setList(context, buttonCount);
    return BlocConsumer<GameCubit, GameState>(
      listener: listener,
      builder: (context, state) {
        return BaseContainer(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: SizeConstants.eight),
                  child: BaseTextWidget(text: '00:${state.timerCount}'),
                ),
              ],
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  context.read<SelectLevelCubit>().choiceButtonColor();

                  context.read<GameCubit>().reset();
                  context.go(RouterPath.home.path);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: ColorConstants.textColor,
                ),
              ),
              title: const ThinkingBrainWidget(),
            ),
            body: Stack(
              children: [
                !state.isTapFirst
                    ? Align(
                      alignment: Alignment.topCenter,
                      child:
                          Text(
                            LocaleKeys.hideNumbersAlert,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: ColorConstants.textColor,
                            ),
                          ).tr(),
                    )
                    : const SizedBox.shrink(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomMultiChildLayout(
                        delegate: CustomMultiChildLayoutDelegate(
                          buttonOffsetList: buttonOffsetList,
                          widgetCount: buttonCount,
                        ),
                        children: buildButtonWidget(buttonCount),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  CustomMultiChildLayoutDelegate({
    required this.widgetCount,
    required this.buttonOffsetList,
  });
  List<Offset> buttonOffsetList;

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
          Offset(buttonOffsetList[i].dx, buttonOffsetList[i].dy),
        );
      }
    }
  }
}

List<Widget> buildButtonWidget(int widgetCount) {
  double buttonSize = SizeConstants.fiftySix;

  List<Widget> numberButtonList = [];
  for (int i = 0; i < widgetCount; i++) {
    numberButtonList.add(
      LayoutId(
        id: i,
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Visibility(
                visible: state.buttonVisibiltyList[i + 1],
                child: GestureDetector(
                  onTap: () {
                    context.read<SettingsCubit>().manageSound();

                    if (i + 1 == 1) {
                      context.read<GameCubit>().firstTap(i + 1);
                    } else {
                      context.read<GameCubit>().buttonCounter(i + 1);
                    }
                  },
                  child: AnimatedCrossFade(
                    duration: DurationConstants.durationLow,
                    crossFadeState:
                        state.isTapFirst
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    secondChild: Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.textColor,
                        borderRadius: BorderRadius.circular(
                          SizeConstants.sixteen,
                        ),
                      ),
                      height: buttonSize,
                      width: buttonSize,
                    ),
                    firstChild: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          SizeConstants.sixteen,
                        ),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      height: buttonSize,
                      width: buttonSize,
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: context.textTheme.titleLarge?.copyWith(
                            color: ColorConstants.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  return numberButtonList;
}
