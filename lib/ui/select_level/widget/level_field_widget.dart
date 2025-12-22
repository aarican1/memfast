import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';

class LevelFieldWidget extends StatelessWidget {
  const LevelFieldWidget({
    super.key,
    required this.levelNumber,
    required this.onPressed,
    required this.colorSetter,
  });

  final int levelNumber;
  final void Function()? onPressed;
  final bool colorSetter;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: SizeConstants.twelve,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LevelDescription.values[levelNumber - 1].description,
          style: context.textTheme.titleMedium?.copyWith(
            color: ColorConstants.textColor,
            fontWeight: FontWeight.bold,
          ),
        ).tr(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                width: 1,
                color:
                    colorSetter
                        ? ColorConstants.textColor
                        : ColorConstants.levelButtonColorHalfElevation,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  SizeConstants.twentyFour,
                ),
              ),
              fixedSize: const Size(double.infinity, SizeConstants.fiftySix),
            ),
            onPressed: colorSetter ? onPressed : null,
            child: Text(
              LocaleKeys.playLevel.tr(),
              style: context.textTheme.bodyLarge?.copyWith(
                color:
                    colorSetter
                        ? ColorConstants.textColor
                        : ColorConstants.levelButtonColorHalfElevation,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum LevelDescription {
  levelOn(1, LocaleKeys.levelOne),
  levelTwo(2, LocaleKeys.levelTwo),
  levelThree(3, LocaleKeys.levelThree),
  levelFour(4, LocaleKeys.levelFour);

  final int number;
  final String description;

  const LevelDescription(this.number, this.description);
}
