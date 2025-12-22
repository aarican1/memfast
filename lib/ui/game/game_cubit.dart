import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:memfast/data/local_database/secure_storage.dart';
import 'package:memfast/data/models/user_model.dart';
import 'package:memfast/generated/locale_keys.g.dart';

import 'package:memfast/ui/game/game_state.dart';

import 'package:memfast/core/utility/enums/firebase_enums.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
    : super(
        GameState(
          isGameDone: false,
          isOneGameOneAd: false,
          scoreCalculated: false,
          whichLevelButton: 5,
          timeisOver: false,
          wrongNumber: false,
          timerCount: 30,
          score: 0,
          isTapFirst: false,
          buttonTapCounter: 1,
          buttonVisibiltyList: List.generate(16, (index) => true),
        ),
      ) {
    startTimerCount();
  }

  void errorMakeNull() {
    emit(state.copyWith(errorMessage: null));
  }

  void dispose() {
    state.timer?.cancel();
  }

  void setLevelButton(int buttonCount) {
    emit(state.copyWith(whichLevelButton: buttonCount));
  }

  void setGameDone(bool value) {
    emit(state.copyWith(isGameDone: value));
  }

  Future<void> updateScoreOnFirebase(
    int score,
    bool isSucces,
    int openLevel,
  ) async {
    if (openLevel < 4) {
      openLevel = openLevel + 1;
    } else {
      openLevel = openLevel;
    }

    final String? username = await SecureStorage.storage.read(key: 'username');
    if (username == null || username.isEmpty) {}
    try {
      final userReferences = MyFirebaseCollectionEnum.users.references;
      final QuerySnapshot snapshot =
          await userReferences.where('username', isEqualTo: username).get();

      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data() as Map<String, dynamic>;
        final UserModel user = const UserModel().fromJson(userData);
        if (user.score == null) {
        } else if (user.openLockLevel == null) {}
        DocumentSnapshot userDoc = snapshot.docs.first;

        if (isSucces) {
          if (user.score! < score) {
            if (openLevel > user.openLockLevel!) {
              await userDoc.reference.update({
                'score': score,
                'openLockLevel': openLevel,
              });
            } else {
              await userDoc.reference.update({'score': score});
            }
          } else {
            if (openLevel > user.openLockLevel!) {
              await userDoc.reference.update({'openLockLevel': openLevel});
            }
          }
        } else {
          if (user.score! < score) {
            await userDoc.reference.update({'score': score});
          } else {}
        }
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: LocaleKeys.somethingWentWrong.tr()));
    }
  }

  Future<void> calculateScore(
    bool isSucces,
    int levelNumber,
    int timerCount,
  ) async {
    int score = 0;

    int levelMultiplier;
    int openLevelValue = 1;
    switch (levelNumber) {
      case 5:
        levelMultiplier = 1;
        openLevelValue = 1;
        break;
      case 10:
        levelMultiplier = 3;
        openLevelValue = 2;
        break;
      case 12:
        levelMultiplier = 6;
        openLevelValue = 3;
        break;
      case 15:
        levelMultiplier = 12;
        openLevelValue = 4;
        break;
      default:
        levelMultiplier = 1;
        break;
    }

    int multiplier = calculateMultiplier(timerCount);

    if (isSucces) {
      score =
          ((state.buttonTapCounter - 1) + (timerCount)) *
          multiplier *
          (levelMultiplier);
    } else {
      if (state.buttonTapCounter > 1) {
        score = (state.buttonTapCounter - 1) + timerCount;
      } else {
        score = 0;
      }
    }
    emit(state.copyWith(score: score, scoreCalculated: true, isGameDone: true));
    await updateScoreOnFirebase(score, isSucces, openLevelValue);
  }

  int calculateMultiplier(int time) {
    if (time >= 20) {
      return 3;
    } else if (time >= 10) {
      return 2;
    } else {
      return 1;
    }
  }

  bool getIsOneGameOneAd() {
    return state.isOneGameOneAd;
  }

  void resume(
    int whichLevelButton,
    int score,
    int buttonTapCounter,
    List<bool> buttonVisibiltyList,
  ) {
    int timerCount = 30;

    emit(
      GameState(
        isOneGameOneAd: true,
        scoreCalculated: false,
        whichLevelButton: whichLevelButton,
        isTapFirst: false,
        wrongNumber: false,
        isGameDone: false,
        score: score,
        buttonTapCounter: buttonTapCounter,
        timeisOver: false,
        buttonVisibiltyList: buttonVisibiltyList,
        timerCount: timerCount,
      ),
    );
  }

  void reset() {
    emit(
      GameState(
        isOneGameOneAd: false,
        scoreCalculated: false,
        whichLevelButton: 5,
        score: 0,
        timerCount: 30,
        isGameDone: false,
        isTapFirst: false,
        buttonTapCounter: 1,
        wrongNumber: false,
        timeisOver: false,
        buttonVisibiltyList: List.generate(16, (index) => true),
      ),
    );
  }

  void startTimerCount() {
    state.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerCount > 0) {
        emit(state.copyWith(timerCount: state.timerCount - 1));
      } else {
        emit(state.copyWith(timeisOver: true, timerCount: 0));
      }
    });
  }

  void firstTap(int id) {
    if (id == state.buttonTapCounter) {
      state.buttonVisibiltyList[id] = false;

      emit(
        state.copyWith(
          buttonVisibiltyList: state.buttonVisibiltyList,
          buttonTapCounter: state.buttonTapCounter + 1,
          isTapFirst: true,
        ),
      );
    } else {
      emit(state.copyWith(wrongNumber: true));
    }
  }

  void buttonCounter(int id) {
    if (id == state.buttonTapCounter) {
      state.buttonVisibiltyList[id] = false;

      emit(
        state.copyWith(
          isTapFirst: true,
          buttonVisibiltyList: state.buttonVisibiltyList,
          buttonTapCounter: state.buttonTapCounter + 1,
        ),
      );
    } else {
      emit(state.copyWith(wrongNumber: true));
    }
  }
}
