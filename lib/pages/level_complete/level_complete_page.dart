// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/game/game_cubit.dart';
import 'package:memfast/pages/game/game_page.dart';
import 'package:memfast/pages/game/game_state.dart';
import 'package:memfast/pages/home/page/home_page.dart';
import 'package:memfast/pages/register/widgets/register_widgets.dart';
import 'package:memfast/pages/select_level/cubit/select_level_cubit.dart';
import 'package:memfast/pages/select_level/page/select_level_page.dart';

import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';

class LevelComplete extends StatelessWidget {
  const LevelComplete({
    super.key,
    required this.mediaQCons,
  });
  final MediaQueryConstants mediaQCons;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            context.read<GameCubit>().reset();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
          child: BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                       
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                        context.read<GameCubit>().reset();
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
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: BaseTextWidget(
                          fontSize: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.appBarFontSize),
                          textColor: ColorConstants.textColor,
                          text: StringConstants.levelComplete),
                    ),
                    BaseTextWidget(
                        fontSize: mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.usernameFontSize),
                        textColor: ColorConstants.textColor,
                        text: '${StringConstants.yourScore}    ${state.score}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                          
                          

                            int buttonCount = state.whichLevelButton;
                            switch (buttonCount) {
                              case 5:
                                buttonCount = 10;
                                context.read<GameCubit>().reset();
                                   
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GamePage(
                                              buttonCount: buttonCount,
                                            )));
                                break;
                              case 10:
                                buttonCount = 12;
                                context.read<GameCubit>().reset();
                                 
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GamePage(
                                              buttonCount: buttonCount,
                                            )));
                                break;
                              case 12:
                                buttonCount = 15;
                                context.read<GameCubit>().reset();
                                  
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GamePage(
                                              buttonCount: buttonCount,
                                            )));
                                break;
                              default:
                                context.read<GameCubit>().reset();
                                context
                                    .read<SelectLevelCubit>()
                                    .choiceButtonColor();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectLevelPage()));
                            }
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
                                  return BaseTextWidget(
                                      fontSize: 20,
                                      textColor: ColorConstants.textColor,
                                      text: state
                                          ? StringConstants.nextLevel
                                          : StringConstants.selectLevel);
                                },
                              ),
                            ),
                          ),
                        ),
                        InkWell(
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
                            child: const Center(
                              child: BaseTextWidget(
                                  fontSize: 20,
                                  textColor: ColorConstants.textColor,
                                  text: StringConstants.retry),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
