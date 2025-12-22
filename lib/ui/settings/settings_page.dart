import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/generated/locale_keys.g.dart';

import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:memfast/ui/settings/settings_state.dart';
import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/media_query_constants.dart';

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
            ),
          ),
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
                      height:
                          mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.width,
                          ) *
                          0.15,
                      width:
                          mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.width,
                          ) *
                          0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color:
                            state
                                ? ColorConstants.colorList[1]
                                : ColorConstants.grey,
                        borderRadius: BorderRadius.circular(
                          mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.width,
                              ) *
                              0.064 *
                              0.366,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          context.read<SettingsCubit>().setAllowMusic();
                        },
                        icon: Center(
                          child: Image.asset(
                            'assets/icons/music.png',
                            width:
                                mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.width,
                                ) *
                                0.1,
                            height:
                                mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.width,
                                ) *
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
                      height:
                          mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.width,
                          ) *
                          0.15,
                      width:
                          mediaQCons.getContantsMediaQueryData(
                            MediaQueryContantsEnum.width,
                          ) *
                          0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color:
                            state
                                ? ColorConstants.colorList[1]
                                : ColorConstants.grey,
                        borderRadius: BorderRadius.circular(
                          mediaQCons.getContantsMediaQueryData(
                                MediaQueryContantsEnum.width,
                              ) *
                              0.064 *
                              0.366,
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          context.read<SettingsCubit>().setAllowSound();
                        },
                        icon: Center(
                          child: Image.asset(
                            'assets/icons/volume.png',
                            width:
                                mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.width,
                                ) *
                                0.09,
                            height:
                                mediaQCons.getContantsMediaQueryData(
                                  MediaQueryContantsEnum.width,
                                ) *
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
                  left:
                      mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.width,
                      ) *
                      0.04,
                ),
                child: BaseTextWidget(text: LocaleKeys.thanksContributor.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
