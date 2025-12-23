import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/gen/assets.gen.dart';

class ThinkingBrainWidget extends StatelessWidget {
  const ThinkingBrainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(
        Assets.lottie.meditatingBrain,
        height: SizeConstants.seventyTwo,
        width: SizeConstants.seventyTwo,
      ),
    );
  }
}
