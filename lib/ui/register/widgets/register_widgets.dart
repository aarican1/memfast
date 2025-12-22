import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/core/utility/constants/size_constants.dart';
import 'package:memfast/core/utility/extension/text_theme_extension.dart';
import 'package:memfast/ui/register/bloc/register_cubit.dart';
import 'package:memfast/ui/register/bloc/register_state.dart';

import 'package:memfast/core/product/constants/color_contants.dart';
import 'package:memfast/core/product/constants/duration_contants.dart';
import 'package:memfast/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ClickAgreementLink extends StatelessWidget {
  const ClickAgreementLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SizeConstants.twentyFour,
        left: SizeConstants.twentyFour,
      ),
      child: Container(
        alignment: AlignmentDirectional.topStart,
        child: TextButton(
          onPressed: () => context.read<RegisterCubit>().launchUpdateUrl(),
          child: Text(
            LocaleKeys.privacyAgreementLink.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorConstants.textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmAgreementSelector extends StatelessWidget {
  const ConfirmAgreementSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SizeConstants.twentyFour,
        left: SizeConstants.twentyFour,
      ),
      child: BlocSelector<RegisterCubit, RegisterState, bool>(
        selector: (state) {
          return state.isAgreementAccept;
        },
        builder: (context, state) {
          return AnimatedCrossFade(
            duration: DurationConstants.duration,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.only(
                top: SizeConstants.twentyFour,
                left: SizeConstants.twentyFour,
              ),
              child:
                  Text(
                    LocaleKeys.confirmAgreementError,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: ColorConstants.textColor,
                    ),
                  ).tr(),
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
    required this.registerFormController,
  });

  final TextEditingController registerFormController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeConstants.twentyFour),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        controller: registerFormController,
        maxLength: 12,
        style: context.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.textColor,
        ),
        decoration: InputDecoration(
          hintText: LocaleKeys.pleaseEnterUsername.tr(),
          hintStyle: context.textTheme.bodyMedium?.copyWith(
            color: ColorConstants.textColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.textColor),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstants.textColor),
          ),
        ),
      ),
    );
  }
}

class YourUsernameTextContainer extends StatelessWidget {
  const YourUsernameTextContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: SizeConstants.twentyFour),
      alignment: Alignment.centerLeft,
      child:
          Text(
            LocaleKeys.yourUsername,
            style: context.textTheme.bodyLarge?.copyWith(
              color: ColorConstants.textColor,
            ),
          ).tr(),
    );
  }
}

class AgreementRowWidget extends StatelessWidget {
  const AgreementRowWidget({super.key});

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
                crossFadeState:
                    state.isAgreementAccept
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                firstChild: Container(
                  height: SizeConstants.twentyFour,
                  width: SizeConstants.twentyFour,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      SizeConstants.twentyFour * 0.24,
                    ),
                  ),
                ),
                secondChild: Container(
                  height: SizeConstants.twentyFour,
                  width: SizeConstants.twentyFour,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      SizeConstants.twentyFour,
                    ),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: SizeConstants.twelve),
          child:
              Text(
                LocaleKeys.acceptPrivacyAgreement,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: ColorConstants.textColor,
                ),
              ).tr(),
        ),
      ],
    );
  }
}

class RegisterAppBarTitle extends StatelessWidget {
  const RegisterAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.memfast,
      style: context.textTheme.displayMedium?.copyWith(
        color: ColorConstants.textColor,
      ),
    ).tr();
  }
}

class UserNameErrorText extends StatelessWidget {
  const UserNameErrorText({super.key});

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
            margin: const EdgeInsets.only(
              left: SizeConstants.twentyFour,
              top: SizeConstants.twentyFour,
            ),
            child:
                Text(
                  LocaleKeys.usernameAlreadyInUse,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: ColorConstants.textColor,
                  ),
                ).tr(),
          ),
          crossFadeState:
              state ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: DurationConstants.duration,
        );
      },
    );
  }
}
