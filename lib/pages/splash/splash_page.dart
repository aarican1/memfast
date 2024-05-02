import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/home/page/home_page.dart';
import 'package:memfast/pages/network_change/bloc/network_change_cubit.dart';

import 'package:memfast/pages/register/register_page.dart';
import 'package:memfast/pages/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/pages/splash/bloc/cubit/splash_cubit.dart';
import 'package:memfast/pages/splash/bloc/state/splash_state.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/string_constants.dart';

import 'package:memfast/utility/exceptions/enums/firebase_enums.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<NetworkChangeCubit>().fetchFirstResults();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SomethingWentWrongDialog(
                      errorMessage: state.errorMessage ?? '');
                });
            context.read<SplashCubit>().errorMakeNull();
          }
          if (state.isVersionOk == true && state.isFirabaseOk == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return state.isLogIn ??
                          false // splash Cubitte false atamasi yapildi
                      ? const HomePage()
                      : RegisterPage(
                          userReferences:
                              MyFirebaseCollectionEnum.users.references,
                        );
                }),
              );
            });
          }
          if (state.isFirabaseOk == true && state.isVersionOk == false) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyUpdateAlertDialog(url: state.updateUri);
                });
          }
        },
        child: const MySplashContainer());
  }
}

class MySplashContainer extends StatelessWidget {
  const MySplashContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: ColorConstants.backgroundGradient,
        ),
        child: Scaffold(
          body: Center(
              child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(
                StringConstants.appName,
                duration: const Duration(seconds: 8),
                textStyle: TextStyle(
                    color: ColorConstants.textColor,
                    fontSize: (MediaQuery.of(context).size.width * 0.11)),
              )
            ],
          )),
        ));
  }
}
