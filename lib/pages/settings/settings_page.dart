import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:memfast/pages/settings/settings_cubit.dart';
import 'package:memfast/pages/settings/settings_state.dart';
import 'package:memfast/product/base_widgets/base_container_widget.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocSelector<SettingsCubit, SettingsState, bool>(
                  selector: (state) {
                    return state.allowMusicPlay!;
                  },
                  builder: (context, state) {
                    return Container(
                      height: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.width) *
                          0.15,
                      width: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.width) *
                          0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: state
                            ? ColorConstants.colorList[1]
                            : ColorConstants.colorList[0],
                        borderRadius: BorderRadius.circular(
                            mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.064 *
                                0.366),
                      ),
                      child: IconButton(
                        onPressed: () async {
                         

                          context.read<SettingsCubit>().setAllowMusic();

                          

                         
                        },
                        icon: Center(
                          child: Image.asset(
                            'lib/assets/icons/music.png',
                            width: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.1,
                            height: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocSelector<SettingsCubit, SettingsState, bool>(
                  selector: (state) {
                    return state.allowSoundPlay!;
                  },
                  builder: (context, state) {
                    return Container(
                      height: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.width) *
                          0.15,
                      width: mediaQCons.getContantsMediaQueryData(
                              MediaQueryContantsEnum.width) *
                          0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: state
                            ? ColorConstants.colorList[1]
                            : ColorConstants.colorList[0],
                        borderRadius: BorderRadius.circular(
                            mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.064 *
                                0.366),
                      ),
                      child: IconButton(
                        onPressed: () {
                          context.read<SettingsCubit>().setAllowSound();
                        },
                        icon: Center(
                          child: Image.asset(
                            'lib/assets/icons/volume.png',
                            width: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.09,
                            height: mediaQCons.getContantsMediaQueryData(
                                    MediaQueryContantsEnum.width) *
                                0.09,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(
                  left: mediaQCons.getContantsMediaQueryData(
                          MediaQueryContantsEnum.width) *
                      0.04),
              child: BaseTextWidget(
                  fontSize: mediaQCons.getContantsMediaQueryData(
                      MediaQueryContantsEnum.appBarFontSize),
                  textColor: ColorConstants.textColor,
                  text: StringConstants.serkanThanksMessage),
            )),
          ],
        ),
      ),
    );
  }
}
