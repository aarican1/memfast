import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/main.dart';
import 'package:memfast/pages/game/game_cubit.dart';
import 'package:memfast/pages/settings/settings_cubit.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SomethingWentWrongDialog extends StatelessWidget {
  SomethingWentWrongDialog({super.key, required this.errorMessage,});
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

// ignore: must_be_immutable
class MyUpdateAlertDialog extends StatelessWidget {
  MyUpdateAlertDialog({
    required this.url,
    super.key,
  });
  Uri? url;
  bool uriNotNull = false;
  void uriIsNotNull(Uri? url) {
    if (url != null) {
      uriNotNull = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry bRCircular =
        BorderRadius.circular(MediaQuery.of(context).size.width * 0.11 * 0.24);
    uriIsNotNull(url);
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
            const Text(StringConstants.appName,
                style: TextStyle(
                    color: ColorConstants.textColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            Text(
                uriNotNull
                    ? StringConstants.updateMessage
                    : 'Something Went Wrong',
                style: const TextStyle(
                  color: ColorConstants.textColor,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                uriNotNull
                    ? ElevatedButton(
                        onPressed: () async {
                          if (await canLaunchUrl(url!)) {
                            await launchUrl(url!);
                          } else {
                            throw 'Could not launch this url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: bRCircular,
                            ),
                            backgroundColor:
                                ColorConstants.buttonBackgroundColor),
                        child: const Text(
                          StringConstants.update,
                          style: TextStyle(
                            color: ColorConstants.textColor,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: bRCircular,
                      ),
                      backgroundColor: ColorConstants.buttonBackgroundColor),
                  child: const Text(
                    StringConstants.exit,
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
