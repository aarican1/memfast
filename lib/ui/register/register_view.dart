import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/generated/locale_keys.g.dart';

import 'package:memfast/ui/home/home_view.dart';
import 'package:memfast/ui/register/bloc/register_cubit.dart';
import 'package:memfast/ui/register/bloc/register_state.dart';
import 'package:memfast/ui/register/widgets/register_widgets.dart';
import 'package:memfast/ui/splash/alert_widget/alert_dialog.dart';
import 'package:memfast/core/product/base_widgets/text_widget.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/core/product/widgets/circular_progress_indicator.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key, required this.userReferences});
  final CollectionReference userReferences;

  final TextEditingController registerFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorConstants.backgroundGradient,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          centerTitle: true,
          title: const RegisterAppBarTitle(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: SizeConstants.thirtyTwo),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                showDialog(
                  context: context,
                  builder:
                      (context) => SomethingWentWrongDialog(
                        errorMessage: state.errorMessage ?? '',
                      ),
                );
                context.read<RegisterCubit>().errorMakeNull();
              }
              if (state.isCreateUsername && state.isAgreementAccept) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeView()),
                  );
                });
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  const YourUsernameTextContainer(),
                  RegisterTextFormField(
                    registerFormController: registerFormController,
                  ),
                  const UserNameErrorText(),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: SizeConstants.twentyFour,
                      top: SizeConstants.twentyFour,
                    ),
                    child: AgreementRowWidget(),
                  ),
                  const ClickAgreementLink(),
                  const ConfirmAgreementSelector(),
                  AnimatedCrossFade(
                    crossFadeState:
                        state.isLoading
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                    secondChild: const CenterCircularIndicator(),
                    firstChild: Padding(
                      padding: const EdgeInsets.only(top: 38),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    SizeConstants.twentyFour,
                                  ),
                                ),
                              ),
                          side: WidgetStateProperty.all<BorderSide>(
                            const BorderSide(color: Colors.white, width: 1.0),
                          ),
                        ),
                        onPressed: () async {
                          String usernameValue = registerFormController.text;
                          if (usernameValue.isEmpty) {
                            await context.read<RegisterCubit>().emptyUserName();
                          } else {
                            await context.read<RegisterCubit>().registerUser(
                              usernameValue,
                            );

                            if (state.isCreateUsername &&
                                state.isAgreementAccept) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeView(),
                                  ),
                                );
                              });
                            }
                          }
                        },
                        child: BaseTextWidget(text: LocaleKeys.signUp.tr()),
                      ),
                    ),
                    duration: DurationConstants.duration,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
