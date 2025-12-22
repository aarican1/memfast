import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/generated/locale_keys.g.dart';

class InternetCheckDialog extends StatelessWidget {
  const InternetCheckDialog({super.key});

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
            BaseTextWidget(text: LocaleKeys.checkNetworkConnection.tr()),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {},
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
                        LocaleKeys.update,
                        style: TextStyle(
                          color: ColorConstants.textColor,
                          fontSize: 16.0,
                        ),
                      ).tr(),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
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
}
