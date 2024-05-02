// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final bool isControllerValueOk;
  final bool isAgreementAccept;
  final bool isFirebaseOk;
  final bool isAlreadyUsername;
  final bool isCreateUsername;
  final bool isLoading;
  final String agreementUrl;
  final String? errorMessage;
  final Uri? uri;

  const RegisterState({
    required this.isControllerValueOk,
    required this.isAgreementAccept,
    required this.isFirebaseOk,
    required this.isAlreadyUsername,
    required this.isCreateUsername,
    required this.isLoading,
    required this.agreementUrl,
    this.errorMessage,
    this.uri,
  });

  @override
  List<Object?> get props => [
        isAlreadyUsername,
        isFirebaseOk,
        errorMessage,
        isLoading,
        isControllerValueOk,
        isAgreementAccept,
        isCreateUsername,
        agreementUrl,
        uri
      ];

  RegisterState copyWith({
    bool? isControllerValueOk,
    bool? isAgreementAccept,
    bool? isFirebaseOk,
    bool? isAlreadyUsername,
    bool? isCreateUsername,
    bool? isLoading,
    String? agreementUrl,
    String? errorMessage,
    Uri? uri,
  }) {
    return RegisterState(
      errorMessage: errorMessage ?? this.errorMessage,
      isControllerValueOk: isControllerValueOk ?? this.isControllerValueOk,
      isAgreementAccept: isAgreementAccept ?? this.isAgreementAccept,
      isFirebaseOk: isFirebaseOk ?? this.isFirebaseOk,
      isAlreadyUsername: isAlreadyUsername ?? this.isAlreadyUsername,
      isCreateUsername: isCreateUsername ?? this.isCreateUsername,
      isLoading: isLoading ?? this.isLoading,
      agreementUrl: agreementUrl ?? this.agreementUrl,
      uri: uri ?? this.uri,
    );
  }
}
