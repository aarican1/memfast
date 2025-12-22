import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:memfast/gen/assets.gen.dart';

class DancerMonkeyWidget extends StatelessWidget {
  const DancerMonkeyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Lottie.asset(Assets.lottie.dancerMonkey));
  }
}
