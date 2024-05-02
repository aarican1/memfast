import 'package:flutter/material.dart';
import 'package:memfast/product/constants/color_contants.dart';

class CenterCircularIndicator extends StatelessWidget {
  const CenterCircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
            backgroundColor: Colors.transparent, color: ColorConstants.textColor),
      ),
    );
  }
}
