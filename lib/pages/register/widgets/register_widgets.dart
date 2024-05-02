import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/register/bloc/register_cubit.dart';
import 'package:memfast/pages/register/bloc/register_state.dart';

import 'package:memfast/product/constants/color_contants.dart';
import 'package:memfast/product/constants/duration_contants.dart';
import 'package:memfast/product/constants/string_constants.dart';

class ClickAgreementLink extends StatelessWidget {
  const ClickAgreementLink({
    super.key,
    required this.titleAppbarColor,
    required this.usernameFontSize,
    required this.width,
  });

  final Color titleAppbarColor;
  final double usernameFontSize;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: usernameFontSize / 2, left: width * 0.02),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        child: TextButton(
          onPressed: () => context.read<RegisterCubit>().launchUpdateUrl(),
          child: Text(
            'Privacy Agreement Link',
            style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: titleAppbarColor,
                decorationThickness: 1.5,
                fontSize: usernameFontSize / 2,
                color: titleAppbarColor),
          ),
        ),
      ),
    );
  }
}

class ConfirmAgreementSelector extends StatelessWidget {
  const ConfirmAgreementSelector({
    super.key,
    required this.usernameFontSize,
    required this.titleAppbarColor,
    required this.width,
  });
  final double usernameFontSize;
  final Color titleAppbarColor;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: usernameFontSize / 2),
      child: BlocSelector<RegisterCubit, RegisterState, bool>(
        selector: (state) {
          return state.isAgreementAccept;
        },
        builder: (context, state) {
          return AnimatedCrossFade(
            duration: DurationConstants.duration,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding:
                  EdgeInsets.only(top: usernameFontSize / 2, left: width * 0.04),
              child: Text(
                StringConstants.confirmAgreementError,
                style: TextStyle(
                    color: titleAppbarColor, fontSize: usernameFontSize / 2),
              ),
            ),
            crossFadeState:
                state ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          );
        },
      ),
    );
  }
}

class RegisterTextFormField extends StatelessWidget {
  const RegisterTextFormField({
    super.key,
    required this.usernameFontSize,
    required this.registerFormController,
    required this.nameFontSize,
    required this.titleAppbarColor,
  });

  final double usernameFontSize;
  final TextEditingController registerFormController;
  final double nameFontSize;
  final Color titleAppbarColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: usernameFontSize / 2),
      child: TextFormField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          controller: registerFormController,
          maxLength: 12,
          style:
              TextStyle(fontSize: nameFontSize, color: ColorConstants.textColor),
          decoration: InputDecoration(
            hintText: StringConstants.pEnterUsNa,
            hintStyle: TextStyle(
                fontSize: nameFontSize * 0.7, color: ColorConstants.textColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: titleAppbarColor)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: titleAppbarColor)),
          )),
    );
  }
}

class YourUsernameTextContainer extends StatelessWidget {
  const YourUsernameTextContainer({
    super.key,
    required this.width,
    required this.usernameFontSize,
    required this.titleAppbarColor,
  });

  final double width;
  final double usernameFontSize;
  final Color titleAppbarColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: width * 0.04),
      alignment: Alignment.centerLeft,
      child: Text(
        StringConstants.yourUsername,
        style: TextStyle(fontSize: usernameFontSize, color: titleAppbarColor),
      ),
    );
  }
}

class AgreementRowWidget extends StatelessWidget {
  const AgreementRowWidget({
    super.key,
    required this.width,
    required this.titleAppbarColor,
    required this.usernameFontSize,
  });

  final double width;
  final Color titleAppbarColor;
  final double usernameFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            state.isAgreementAccept;
          },
          builder: (context, state) {
            return InkWell(
                onTap: () {
                  context.read<RegisterCubit>().acceptAgreement();
                },
                child: AnimatedCrossFade(
                  duration: DurationConstants.duration,
                  crossFadeState: state.isAgreementAccept
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: Container(
                    height: width * 0.06,
                    width: width * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.06 * 0.24),
                    ),
                  ),
                  secondChild: Container(
                    height: width * 0.06,
                    width: width * 0.06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.06 * 0.24),
                        border: Border.all(width: 1, color: Colors.white)),
                  ),
                ));
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: Text(
            StringConstants.acceptMessage,
            style: TextStyle(
                color: titleAppbarColor, fontSize: usernameFontSize / 2),
          ),
        ),
      ],
    );
  }
}

class RegisterAppBarTitle extends StatelessWidget {
  const RegisterAppBarTitle({
    super.key,
    required this.appBarFontSize,
    required this.titleAppbarColor,
  });

  final double appBarFontSize;
  final Color titleAppbarColor;

  @override
  Widget build(BuildContext context) {
    return Text(StringConstants.appName,
        style: TextStyle(fontSize: appBarFontSize, color: titleAppbarColor));
  }
}

class UserNameErrorText extends StatelessWidget {
  const UserNameErrorText({
    super.key,
    required this.width,
    required this.usernameFontSize,
    required this.titleAppbarColor,
  });

  final double width;
  final double usernameFontSize;
  final Color titleAppbarColor;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegisterCubit, RegisterState, bool>(
      selector: (state) {
        return state.isAlreadyUsername;
      },
      builder: (context, state) {
        return AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: width * 0.04, top: width * 0.045),
            child: Text(StringConstants.usernameErrorMessage,
                style: TextStyle(
                    fontSize: usernameFontSize / 2, color: titleAppbarColor)),
          ),
          crossFadeState:
              state ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: DurationConstants.duration,
        );
      },
    );
  }
}
