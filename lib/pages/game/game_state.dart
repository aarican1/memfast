// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GameState extends Equatable {
  final int whichLevelButton;
  final bool scoreCalculated;
  final bool isTapFirst;
  final bool wrongNumber;
  final bool isOneGameOneAd;
  final int score;
  Timer? timer;
  final String? errorMessage;

  final int buttonTapCounter;
  final bool timeisOver;
  final List<bool> buttonVisibiltyList;
  final int timerCount;
  GameState({
    required this.isOneGameOneAd,
    required this.whichLevelButton,
    required this.scoreCalculated,
    required this.isTapFirst,
    required this.wrongNumber,
    required this.score,
    this.errorMessage,
    this.timer,
    required this.buttonTapCounter,
    required this.timeisOver,
    required this.buttonVisibiltyList,
    required this.timerCount,
  });

  @override
  List<Object?> get props => [
    isOneGameOneAd,
        wrongNumber,
        errorMessage,
        isTapFirst,
        whichLevelButton,
        scoreCalculated,
        timerCount,
        score,
        timer,
        buttonTapCounter,
        buttonVisibiltyList,
        timeisOver
      ];

  GameState copyWith({
    int? whichLevelButton,
    bool? scoreCalculated,
    bool? isTapFirst,
    bool? wrongNumber,
    bool? isOneGameOneAd,
    int? score,
    Timer? timer,
    String? errorMessage,
    int? buttonTapCounter,
    bool? timeisOver,
    List<bool>? buttonVisibiltyList,
    int? timerCount,
  }) {
    return GameState(
      whichLevelButton: whichLevelButton ?? this.whichLevelButton,
      scoreCalculated: scoreCalculated ?? this.scoreCalculated,
      isTapFirst: isTapFirst ?? this.isTapFirst,
      wrongNumber: wrongNumber ?? this.wrongNumber,
      isOneGameOneAd: isOneGameOneAd ?? this.isOneGameOneAd,
      score: score ?? this.score,
      timer: timer ?? this.timer,
      errorMessage: errorMessage ?? this.errorMessage,
      buttonTapCounter: buttonTapCounter ?? this.buttonTapCounter,
      timeisOver: timeisOver ?? this.timeisOver,
      buttonVisibiltyList: buttonVisibiltyList ?? this.buttonVisibiltyList,
      timerCount: timerCount ?? this.timerCount,
    );
  }
}
