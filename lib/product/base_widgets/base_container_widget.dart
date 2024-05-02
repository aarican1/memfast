import 'package:flutter/material.dart';
import 'package:memfast/product/constants/color_contants.dart';

// ignore: must_be_immutable
class BaseContainer extends StatelessWidget {
   BaseContainer({super.key , required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(gradient: ColorConstants.backgroundGradient),
          child: child,
    );
  }
}
