import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:memfast/config/route/router_path.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/enums/firebase_enums.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:memfast/ui/sign_up/bloc/register_cubit.dart';
import 'package:memfast/ui/sign_up/bloc/register_state.dart';
import 'package:memfast/ui/sign_up/widgets/register_widgets.dart';
import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/core/product/widgets/circular_progress_indicator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController registerFormController = TextEditingController();
  late final CollectionReference userReferences;

  @override
  void initState() {
    userReferences = MyFirebaseCollectionEnum.users.references;
    super.initState();
  }

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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? ""),
                    backgroundColor: ColorConstants.buttonBackgroundColor,
                    duration: const Duration(seconds: 2),
                  ),
                );
                context.read<RegisterCubit>().errorMakeNull();
              }
              if (state.isCreateUsername && state.isAgreementAccept) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go(RouterPath.home.path);
                });
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
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
                              await context
                                  .read<RegisterCubit>()
                                  .emptyUserName();
                            } else {
                              await context.read<RegisterCubit>().registerUser(
                                usernameValue,
                              );

                              if (state.isCreateUsername &&
                                  state.isAgreementAccept) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  context.go(RouterPath.home.path);
                                });
                              }
                            }
                          },
                          child: Text(
                            LocaleKeys.signUp.tr(),
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.textColor,
                            ),
                          ),
                        ),
                      ),
                      duration: DurationConstants.duration,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
