// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:memfast/data/models/user_model.dart';

class BestScoresState extends Equatable {
  final List<UserModel?>? userList;
  final bool? isloading;
  final List<UserModel?>? bestScore;
  final List<UserModel?>? rankList;
  final bool? isUserReaded;
  final int personalIndex;
  final String playerName;
  final String? errorMessage;

  const BestScoresState({
    this.rankList,
    this.isUserReaded,
    this.errorMessage,
    required this.personalIndex,
    required this.playerName,
    this.isloading,
    this.bestScore,
    this.userList,
  });
  @override
  List<Object?> get props => [
    userList,
    errorMessage,
    personalIndex,
    playerName,
    rankList,
    isUserReaded,
    bestScore,
    isloading,
  ];

  BestScoresState copyWith({
    List<UserModel?>? userList,
    String? errorMessage,
    List<UserModel?>? rankList,
    bool? isloading,
    int? personalIndex,
    String? playerName,
    bool? isUserReaded,
    List<UserModel?>? bestScore,
  }) {
    return BestScoresState(
      rankList: rankList ?? this.rankList,
      errorMessage: errorMessage ?? this.errorMessage,
      personalIndex: personalIndex ?? this.personalIndex,
      playerName: playerName ?? this.playerName,
      userList: userList ?? this.userList,
      isUserReaded: isUserReaded ?? this.isUserReaded,
      isloading: isloading ?? this.isloading,
      bestScore: bestScore ?? this.bestScore,
    );
  }
}
