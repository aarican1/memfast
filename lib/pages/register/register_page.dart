import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:memfast/pages/home/page/home_page.dart';
import 'package:memfast/pages/register/bloc/register_cubit.dart';
import 'package:memfast/pages/register/bloc/register_state.dart';
import 'package:memfast/pages/register/widgets/register_widgets.dart';
import 'package:memfast/pages/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/product/base_widgets/text_widget.dart';
import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/duration_contants.dart';
import 'package:memfast/product/constants/media_query_constants.dart';
import 'package:memfast/product/widgets/circular_progress_indicator.dart';
//
///
////
////  BASE TEXT KULLAN UNUTMA
//// TEXTFORM FİELD KULLANICI KLAVYEDEN KARAKTER GİRMEZSE İLERLETME
////
/////
////

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.userReferences});
  final CollectionReference userReferences;

  final TextEditingController registerFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MediaQueryConstants mediaQCons = MediaQueryConstants(context: context);
    double width = MediaQuery.of(context).size.width;
    double appBarFontSize = MediaQuery.of(context).size.width * 0.11;
    Color titleAppbarColor = Colors.white;
    double usernameFontSize = MediaQuery.of(context).size.width * 0.09;
    double nameFontSize = MediaQuery.of(context).size.width * 0.06;
    double bodyPadding = MediaQuery.of(context).size.height * 0.13;
    double appbarPadding = MediaQuery.of(context).size.height * 0.045;
    return Container(
        decoration:
            const BoxDecoration(gradient: ColorConstants.backgroundGradient),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: appbarPadding * 2,
            centerTitle: true,
            title: Padding(
              padding: EdgeInsets.only(top: appbarPadding),
              child: RegisterAppBarTitle(
                  appBarFontSize: appBarFontSize,
                  titleAppbarColor: titleAppbarColor),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: bodyPadding,
            ),
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  showDialog(
                      context: context,
                      builder: (context) => SomethingWentWrongDialog(
                          errorMessage: state.errorMessage ?? ''));
                            context.read<RegisterCubit>().errorMakeNull();
                }
                if (state.isCreateUsername && state.isAgreementAccept) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    YourUsernameTextContainer(
                        width: width,
                        usernameFontSize: usernameFontSize,
                        titleAppbarColor: titleAppbarColor),
                    RegisterTextFormField(
                        usernameFontSize: usernameFontSize,
                        registerFormController: registerFormController,
                        nameFontSize: nameFontSize,
                        titleAppbarColor: titleAppbarColor),
                    UserNameErrorText(
                        width: width,
                        usernameFontSize: usernameFontSize,
                        titleAppbarColor: titleAppbarColor),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.04,
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: AgreementRowWidget(
                          width: width,
                          titleAppbarColor: titleAppbarColor,
                          usernameFontSize: usernameFontSize),
                    ),
                    ClickAgreementLink(
                      titleAppbarColor: titleAppbarColor,
                      usernameFontSize: usernameFontSize,
                      width: width,
                    ),
                    ConfirmAgreementSelector(
                      usernameFontSize: usernameFontSize,
                      titleAppbarColor: titleAppbarColor,
                      width: width,
                    ),
                    AnimatedCrossFade(
                      crossFadeState: state.isLoading
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      secondChild: const CenterCircularIndicator(),
                      firstChild: Padding(
                        padding: const EdgeInsets.only(top: 38),
                        child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        mediaQCons.getContantsMediaQueryData(
                                                MediaQueryContantsEnum.height) *
                                            0.064 *
                                            0.366)),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              String usernameValue = registerFormController.text;
                              if (usernameValue.isEmpty) {
                                await context
                                    .read<RegisterCubit>()
                                    .emptyUserName();
                              } else {
                                await context
                                    .read<RegisterCubit>()
                                    .registerUser(usernameValue);

                                if (state.isCreateUsername &&
                                    state.isAgreementAccept) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  });
                                }
                              }
                            },
                            child: BaseTextWidget(
                                fontSize: nameFontSize,
                                textColor: ColorConstants.textColor,
                                text: 'Sign Up')),
                      ),
                      duration: DurationConstants.duration,
                    )
                  ],
                );
              },
            ),
          ),
        ));
  }
}
