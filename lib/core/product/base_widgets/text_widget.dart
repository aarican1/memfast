import 'package:flutter/material.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';

class BaseTextWidget extends StatelessWidget {
  const BaseTextWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyLarge?.copyWith(
        color: ColorConstants.textColor,
      ),
    );
  }
}
