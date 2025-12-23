// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/ui/game/game_cubit.dart';
import 'package:memfast/ui/home/widgets/how_to_play_button.dart';
import 'package:memfast/ui/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/ui/select_level/state/select_level_state.dart';
import 'package:memfast/ui/select_level/widget/level_field_widget.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:memfast/generated/locale_keys.g.dart';
part 'select_level_mixin.dart';

class SelectLevelView extends StatelessWidget with SelectLevelMixin {
  const SelectLevelView({super.key});

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
          title:
              Text(
                LocaleKeys.selectLevel,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: ColorConstants.textColor,
                ),
              ).tr(),
        ),
        body: Center(
          child: BlocConsumer<SelectLevelCubit, SelectLevelState>(
            listener: listener,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.twentyFour,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: SizeConstants.twentyFour,
                  children: [
                    const SizedBox(height: SizeConstants.twentyFour),
                    LevelFieldWidget(
                      colorSetter: state.openLevelList?[0] ?? true,
                      onPressed: () {
                        context.read<GameCubit>().reset();
                        state.openLevelList?[0] ?? true
                            ? context.go("${RouterPath.game.path}/${5}")
                            : null;
                      },

                      levelNumber: 1,
                    ),
                    LevelFieldWidget(
                      colorSetter: state.openLevelList?[1] ?? true,
                      onPressed: () {
                        context.read<GameCubit>().reset();
                        state.openLevelList?[1] ?? true
                            ? context.go("${RouterPath.game.path}/${10}")
                            : null;
                      },

                      levelNumber: 2,
                    ),
                    LevelFieldWidget(
                      colorSetter: state.openLevelList?[2] ?? false,
                      onPressed: () {
                        context.read<GameCubit>().reset();

                        state.openLevelList?[2] ?? false
                            ? context.go("${RouterPath.game.path}/${12}")
                            : null;
                      },

                      levelNumber: 3,
                    ),
                    LevelFieldWidget(
                      colorSetter: state.openLevelList?[3] ?? false,
                      onPressed: () {
                        context.read<GameCubit>().reset();
                        state.openLevelList?[3] ?? false
                            ? context.go("${RouterPath.game.path}/${15}")
                            : null;
                      },
                      levelNumber: 4,
                    ),
                    const HowToPlayButton(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
