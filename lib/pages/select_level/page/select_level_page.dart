// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/game/game_cubit.dart';

import 'package:memfast/pages/game/game_page.dart';
import 'package:memfast/pages/home/page/home_page.dart';
import 'package:memfast/pages/register/widgets/register_widgets.dart';
import 'package:memfast/pages/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/pages/select_level/state/select_level_state.dart';
import 'package:memfast/pages/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';

class SelectLevelPage extends StatelessWidget {
  const SelectLevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryConstants mediaQCons = MediaQueryConstants(context: context);
    return BaseContainer(
        child: PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
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
                  MediaQueryContantsEnum.appbarPadding),
            ),
            child: RegisterAppBarTitle(
                appBarFontSize: mediaQCons.getContantsMediaQueryData(
                    MediaQueryContantsEnum.appBarFontSize),
                titleAppbarColor: ColorConstants.textColor),
          ),
        ),
        body: Center(
          child: BlocConsumer<SelectLevelCubit, SelectLevelState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                showDialog(
                  context: context,
                  builder: (context) => SomethingWentWrongDialog(
                      errorMessage: state.errorMessage ?? ''),
                );
                  context.read<SelectLevelCubit>().errorMakeNull();
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LevelTextButton(
                    colorSetter: state.openLevelList?[0] ?? true,
                    onPressed: () {
                      context.read<GameCubit>().reset();
                      state.openLevelList?[0] ?? true
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const GamePage(
                                        buttonCount: 5,
                                      )))
                          : null;
                    },
                    mediaQCons: mediaQCons,
                    levelNumber: 1,
                  ),
                  LevelTextButton(
                    colorSetter: state.openLevelList?[1] ?? true,
                    onPressed: () {
                      context.read<GameCubit>().reset();
                      state.openLevelList?[1] ?? true
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const GamePage(
                                        buttonCount: 10,
                                      )))
                          : null;
                    },
                    mediaQCons: mediaQCons,
                    levelNumber: 2,
                  ),
                  LevelTextButton(
                    colorSetter: state.openLevelList?[2] ?? false,
                    onPressed: () {
                      context.read<GameCubit>().reset();
                      state.openLevelList?[2] ?? false
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const GamePage(
                                        buttonCount: 12,
                                      )))
                          : null;
                    },
                    mediaQCons: mediaQCons,
                    levelNumber: 3,
                  ),
                  LevelTextButton(
                    colorSetter: state.openLevelList?[3] ?? false,
                    onPressed: () {
                      context.read<GameCubit>().reset();
                      state.openLevelList?[3] ?? false
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const GamePage(
                                        buttonCount: 15,
                                      )))
                          : null;
                    },
                    mediaQCons: mediaQCons,
                    levelNumber: 4,
                  )
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}

class LevelTextButton extends StatelessWidget {
  const LevelTextButton({
    super.key,
    required this.mediaQCons,
    required this.levelNumber,
    required this.onPressed,
    required this.colorSetter,
  });

  final MediaQueryConstants mediaQCons;
  final int levelNumber;
  final void Function()? onPressed;
  final bool colorSetter;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: BaseTextWidget(
            fontSize: mediaQCons.getContantsMediaQueryData(
                MediaQueryContantsEnum.usernameFontSize),
            textColor:
                ColorConstants.textColor.withOpacity(colorSetter ? 1 : 0.5),
            text: 'Level $levelNumber'));
  }
}
