// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/google_ads/google_ads_cubit.dart';

import 'package:memfast/ui/game/game_cubit.dart';

import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';

class GoogleAdsErrorAlert extends StatelessWidget {
  GoogleAdsErrorAlert({super.key, required this.errorMessage});
  String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SizeConstants.twentyFour),
      ),
      content: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(SizeConstants.twentyFour),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseTextWidget(text: LocaleKeys.memfast.tr()),
            const SizedBox(height: 16.0),
            BaseTextWidget(text: LocaleKeys.somethingWentWrong.tr()),
            const SizedBox(height: 16.0),
            BaseTextWidget(text: errorMessage),
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
                      borderRadius: BorderRadius.circular(
                        SizeConstants.twentyFour,
                      ),
                    ),
                    backgroundColor: ColorConstants.buttonBackgroundColor,
                  ),
                  child:
                      const Text(
                        LocaleKeys.retry,
                        style: TextStyle(
                          color: ColorConstants.textColor,
                          fontSize: 16.0,
                        ),
                      ).tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
