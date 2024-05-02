import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/network_change/bloc/network_change_cubit.dart';
import 'package:memfast/pages/network_change/bloc/network_change_state.dart';
import 'package:memfast/pages/splash/splash_page.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/services/network_change_manage/network_change_enum_extensions.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryConstants mediaQCons = MediaQueryConstants(context: context);
    return Scaffold(
      body: BlocListener<NetworkChangeCubit, NetworkChangeState>(
        listener: (context, state) {
          if (state.networkChangeResults == NetworkChangeResults.on) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SplashPage()));
          }
        },
        child: Center(
            child: BaseTextWidget(
          text: 'SomethingWentWrong',
          textColor: ColorConstants.textColor,
          fontSize: mediaQCons
              .getContantsMediaQueryData(MediaQueryContantsEnum.usernameFontSize),
        )),
      ),
    );
  }
}
