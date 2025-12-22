import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/gen/assets.gen.dart';

class BrainAnimation extends StatelessWidget {
  const BrainAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeConstants.fortyEight),
      child: Lottie.asset(Assets.lottie.brain),
    );
  }
}
