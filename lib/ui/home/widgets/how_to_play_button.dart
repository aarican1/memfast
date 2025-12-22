import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';

class HowToPlayButton extends StatelessWidget {
  const HowToPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.push(RouterPath.howToPlay.path);
      },
      child:
          Text(
            LocaleKeys.howToPlayButton,
            style: context.textTheme.bodyLarge?.copyWith(
              color: ColorConstants.blue,
            ),
          ).tr(),
    );
  }
}
