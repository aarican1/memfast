// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SelectLevelState extends Equatable {
  final int openLockLevel;
  final List<bool>? openLevelList;
  final String? errorMessage;
  const SelectLevelState(
      {required this.openLockLevel, this.openLevelList, this.errorMessage});

  @override
  List<Object?> get props => [openLevelList, openLockLevel, errorMessage];

  SelectLevelState copyWith({
    int? openLockLevel,
    String? errorMessage,
    List<bool>? openLevelList,
  }) {
    return SelectLevelState(
      errorMessage: errorMessage ?? this.errorMessage,
      openLockLevel: openLockLevel ?? this.openLockLevel,
      openLevelList: openLevelList ?? this.openLevelList,
    );
  }
}
