import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/core/product/base_widgets/base_container_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';

class HowToPlayView extends StatelessWidget {
  const HowToPlayView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          context.pop();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: SizeConstants.thirtyTwo,
                color: ColorConstants.textColor,
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ),

          body: Padding(
            padding: const EdgeInsets.all(SizeConstants.twentyFour),
            child: Center(
              child:
                  Text(
                    LocaleKeys.howToPlay,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: ColorConstants.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
            ),
          ),
        ),
      ),
    );
  }
}
