import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/gen/assets.gen.dart';

class SadFaceWidget extends StatelessWidget {
  const SadFaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(
        Assets.lottie.sadFace1,
        height: SizeConstants.oneHundred,
        width: SizeConstants.oneHundred,
      ),
    );
  }
}
