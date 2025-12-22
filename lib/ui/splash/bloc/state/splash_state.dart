// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  const SplashState(
      {this.clientVersion,
      this.errorMessage,
      this.updateUri,
      this.isLogIn,
      this.databaseVersion,
      this.isVersionOk,
      this.isFirabaseOk});

  final bool? isVersionOk;
  final bool? isFirabaseOk;
  final bool? isLogIn;
  final String? errorMessage;
  final String? databaseVersion;
  final String? clientVersion;
  final Uri? updateUri;

  @override
  List<Object?> get props => [
        isVersionOk,
        isFirabaseOk,
        isLogIn,
        errorMessage,
        databaseVersion,
        clientVersion,
        updateUri
      ];

  SplashState copyWith(
      {bool? isVersionOk,
      bool? isFirabaseOk,
      bool? isLogIn,
      String? errorMessage,
      String? databaseVersion,
      String? clientVersion,
      Uri? updateUri}) {
    return SplashState(
      errorMessage: errorMessage ?? this.errorMessage,
      isVersionOk: isVersionOk ?? this.isVersionOk,
      isFirabaseOk: isFirabaseOk ?? this.isFirabaseOk,
      isLogIn: isLogIn ?? this.isLogIn,
      databaseVersion: databaseVersion ?? this.databaseVersion,
      clientVersion: clientVersion ?? this.clientVersion,
      updateUri: updateUri ?? this.updateUri,
    );
  }
}
