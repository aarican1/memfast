// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:memfast/services/network_change_manage/network_change_enum_extensions.dart';

class NetworkChangeState extends Equatable {
  final NetworkChangeResults networkChangeResults;
  const NetworkChangeState({
    required this.networkChangeResults,
    required  this.isFirstCheck
  });
  final bool isFirstCheck;
  @override
  List<Object?> get props => [networkChangeResults,isFirstCheck];

  NetworkChangeState copyWith({
    NetworkChangeResults? networkChangeResults,
    bool? isFirstCheck,
  }) {
    return NetworkChangeState(
      networkChangeResults: networkChangeResults ?? this.networkChangeResults,
      isFirstCheck: isFirstCheck ?? this.isFirstCheck,
    );
  }
}
