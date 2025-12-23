import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/size_extension.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/game/game_cubit.dart';
import 'package:memfast/ui/game/game_state.dart';
import 'package:memfast/ui/level_complete/widget/dancer_monkey_widget.dart';
import 'package:memfast/ui/sign_up/widgets/register_widgets.dart';
import 'package:memfast/ui/select_level/cubit/select_level_cubit.dart';

import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
part 'level_complete_mixin.dart';

class LevelCompleteView extends StatefulWidget {
  const LevelCompleteView({super.key});

  @override
  State<LevelCompleteView> createState() => _LevelCompleteViewState();
}

class _LevelCompleteViewState extends State<LevelCompleteView>
    with _LevelCompleteViewMixin {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop || isNavigating) return;
          Future.microtask(() {
            if (context.mounted) {
              context.read<GameCubit>().reset();
              context.go(RouterPath.home.path);
            }
          });
        },
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => backButton(context),
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
                  vertical: SizeConstants.sixteen,
                  horizontal: SizeConstants.sixteen,
                ),
                child: Column(
                  spacing: context.dynamicHeigth(0.02),
                  children: [
                    Text(
                      LocaleKeys.levelComplete.tr(),
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const DancerMonkeyWidget(),
                    Text(
                      LocaleKeys.congrulations,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ).tr(),
                    Text(
                      '${LocaleKeys.yourScore.tr()}:   ${state.score}',
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: ColorConstants.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      spacing: SizeConstants.sixteen,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:
                                () =>
                                    state.whichLevelButton == 15
                                        ? selectLevelOnTap(context, state)
                                        : nextLevelOnTap(context, state),
                            child: Container(
                              height: SizeConstants.fiftySix,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorConstants.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                  SizeConstants.twentyFour,
                                ),
                              ),
                              child: Center(
                                child: BlocSelector<GameCubit, GameState, bool>(
                                  selector: (state) {
                                    if (state.whichLevelButton == 15) {
                                      return false;
                                    } else {
                                      return true;
                                    }
                                  },
                                  builder: (context, state) {
                                    return Text(
                                      state
                                          ? LocaleKeys.nextLevel.tr()
                                          : LocaleKeys.selectLevel.tr(),
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: ColorConstants.textColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => retryOnTap(context, state),
                            child: Container(
                              height: SizeConstants.fiftySix,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorConstants.buttonBackgroundColor,
                                borderRadius: BorderRadius.circular(
                                  SizeConstants.twentyFour,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  LocaleKeys.retry.tr(),
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    color: ColorConstants.textColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
