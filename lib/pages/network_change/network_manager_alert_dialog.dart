import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/constants/string_constants.dart';

class InternetCheckDialog extends StatelessWidget {
  const InternetCheckDialog({
    super.key,
  });

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
                    MediaQueryContantsEnum.nameFontSize),
                textColor: ColorConstants.textColor,
                text: StringConstants.internetcheck),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: bRCircular,
                      ),
                      backgroundColor: ColorConstants.buttonBackgroundColor),
                  child: const Text(
                    StringConstants.update,
                    style: TextStyle(
                      color: ColorConstants.textColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
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
