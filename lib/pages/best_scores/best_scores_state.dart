// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:memfast/models/user_model.dart';

class BestScoresState extends Equatable {
  final List<UserModel?>? userList;
  final bool? isloading;
  final List<UserModel?>? bestScore;
  final List<UserModel?>? rankList;
  final bool? isUserReaded;
  final int personalIndex;
    final String? errorMessage;

  const BestScoresState(
      {this.rankList,
      this.isUserReaded,
      this.errorMessage,
      required this.personalIndex,
      this.isloading,
      this.bestScore,
      this.userList});
  @override
  List<Object?> get props =>
      [userList,errorMessage, personalIndex, rankList, isUserReaded, bestScore, isloading];

  BestScoresState copyWith({
    List<UserModel?>? userList,
    String? errorMessage,
    List<UserModel?>? rankList,
    bool? isloading,
    int? personalIndex,
    bool? isUserReaded,
    List<UserModel?>? bestScore,
  }) {
    return BestScoresState(
      rankList: rankList ?? this.rankList,
       errorMessage: errorMessage ?? this.errorMessage,
      personalIndex: personalIndex ?? this.personalIndex,
      userList: userList ?? this.userList,
      isUserReaded: isUserReaded ?? this.isUserReaded,
      isloading: isloading ?? this.isloading,
      bestScore: bestScore ?? this.bestScore,
    );
  }
}
