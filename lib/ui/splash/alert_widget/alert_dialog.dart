import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/main.dart';
import 'package:memfast/ui/game/game_cubit.dart';
import 'package:memfast/ui/settings/settings_cubit.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SomethingWentWrongDialog extends StatelessWidget {
  SomethingWentWrongDialog({super.key, required this.errorMessage});
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
                    context.read<GameCubit>().errorMakeNull();
                    context.read<GameCubit>().reset();
                    context.read<SettingsCubit>().stopMusic();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
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

// ignore: must_be_immutable
class MyUpdateAlertDialog extends StatelessWidget {
  MyUpdateAlertDialog({required this.url, super.key});
  Uri? url;
  bool uriNotNull = false;
  void uriIsNotNull(Uri? url) {
    if (url != null) {
      uriNotNull = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry bRCircular = BorderRadius.circular(
      MediaQuery.of(context).size.width * 0.11 * 0.24,
    );
    uriIsNotNull(url);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: bRCircular),
      content: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: bRCircular,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              LocaleKeys.appName,
              style: TextStyle(
                color: ColorConstants.textColor,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            const SizedBox(height: 16.0),
            Text(
              uriNotNull
                  ? LocaleKeys.updateMessage.tr()
                  : LocaleKeys.somethingWentWrong.tr(),
              style: const TextStyle(
                color: ColorConstants.textColor,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uriNotNull
                    ? ElevatedButton(
                      onPressed: errorOnPressed,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: bRCircular),
                        backgroundColor: ColorConstants.buttonBackgroundColor,
                      ),
                      child:
                          const Text(
                            LocaleKeys.update,
                            style: TextStyle(
                              color: ColorConstants.textColor,
                              fontSize: 16.0,
                            ),
                          ).tr(),
                    )
                    : const SizedBox.shrink(),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: bRCircular),
                    backgroundColor: ColorConstants.buttonBackgroundColor,
                  ),
                  child:
                      const Text(
                        LocaleKeys.exit,
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

  void errorOnPressed() async {
    if (Platform.isIOS) {
      if (await canLaunchUrl(url!)) {
        await launchUrl(url!, mode: LaunchMode.externalApplication);
      }
    } else {
      if (await canLaunchUrl(url!)) {
        await launchUrl(url!);
      } else {
        return;
      }
    }
  }
}
