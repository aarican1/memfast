// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';

import 'package:memfast/pages/game/game_cubit.dart';

import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';

class GoogleAdsErrorAlert extends StatelessWidget {
  GoogleAdsErrorAlert({
    super.key,
    required this.errorMessage,
  });
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    MediaQueryConstants mediaQCons = MediaQueryConstants(context: context);
    BorderRadiusGeometry bRCircular =
        BorderRadius.circular(MediaQuery.of(context).size.width * 0.11 * 0.24);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: bRCircular,
      ),
      content: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration:
            BoxDecoration(color: Colors.transparent, borderRadius: bRCircular),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseTextWidget(
                fontSize: mediaQCons.getContantsMediaQueryData(
                    MediaQueryContantsEnum.usernameFontSize),
                textColor: ColorConstants.textColor,
                text: StringConstants.appName),
            const SizedBox(height: 16.0),
            BaseTextWidget(
                fontSize: mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.nameFontSize) *
                    0.6,
                textColor: ColorConstants.textColor,
                text: StringConstants.sWentWrong),
            const SizedBox(height: 16.0),
            BaseTextWidget(
                fontSize: mediaQCons.getContantsMediaQueryData(
                        MediaQueryContantsEnum.nameFontSize) *
                    0.6,
                textColor: ColorConstants.textColor,
                text: errorMessage),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                      context.read<GoogleAdsCubit>().loadAd();
                    context.read<GameCubit>().errorMakeNull();
                  

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: bRCircular,
                      ),
                      backgroundColor: ColorConstants.buttonBackgroundColor),
                  child: const Text(
                    StringConstants.retry,
                    style: TextStyle(
                      color: ColorConstants.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
