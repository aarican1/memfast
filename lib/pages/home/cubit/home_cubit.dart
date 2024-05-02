import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/local_database/secure_storage.dart';
import 'package:memfast/models/user_model.dart';
import 'package:memfast/pages/best_scores/best_scores_state.dart';

import 'package:memfast/utility/exceptions/enums/firebase_enums.dart';

class HomeCubit extends Cubit<BestScoresState> {
  HomeCubit()
      : super(const BestScoresState(
            isloading: false, bestScore: [], userList: [], personalIndex: -1)) {
    Future.microtask(() => getUserList());
  }

  Future<void> getUserList() async {
    final userReferences = MyFirebaseCollectionEnum.users.references;
    final response = await userReferences.withConverter(
      fromFirestore: (snapshot, options) {
        return const UserModel().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        if (value == null) {
           emit(state.copyWith(errorMessage: 'value is null'));
      
        }
        return value!.toJson();
      },
    ).get();

    List<UserModel?>? userList = response.docs.map((doc) => doc.data()).toList();
    if (userList.isNotEmpty) {
      emit(state.copyWith(userList: userList));
    
    } else {
      emit(state.copyWith(errorMessage: 'User list not find'));
    }
  }

  Future<void> selectionBestScore() async {
   await  getUserList();
    emit(state.copyWith(isloading: true));
    final List<UserModel?>? userList = state.userList;

   
    if (userList == null || userList.isEmpty) {
      emit(state.copyWith(bestScore: [], isloading: false));
    } else {
      if (userList.length <= 1) {
        emit(state.copyWith(bestScore: userList));
      } else {
        List<UserModel?> sortedList = quickSortScore(userList);
       
        emit(state.copyWith(bestScore: [
          sortedList[0],
          sortedList[1],
          sortedList[2],
        ], isloading: false));
      }
    }
  }
void isReadBlock(){emit(state.copyWith(isUserReaded: false));}

 void errorMakeNull() {
    emit(state.copyWith(errorMessage: null));
  }

  Future<void> personalScore() async {
    final String? usernameResult = await SecureStorage.readData('username');
    await getUserList();
    final List<UserModel?>? userList = state.userList;
    if (usernameResult == null || usernameResult.isEmpty) {
      emit(state.copyWith(isUserReaded: false));
    } else {
      if (userList == null || userList.isEmpty) {
        emit(state.copyWith(isUserReaded: false));
      } else {
        final sortedList = quickSortScore(userList);
        if(sortedList.isNotEmpty){
           emit(state.copyWith(rankList: sortedList));
        }
      final int userIndex=  findUserIndex(sortedList, usernameResult);
     
      if(userIndex<0){
         emit(state.copyWith(isUserReaded: false));
      }
      else{
       emit(state.copyWith(isUserReaded: true,personalIndex: userIndex));
      }
      }
    }
  }

  int findUserIndex(List<UserModel?>? list, String targetUserName) {
    if (list == null || list.isEmpty) {
      return -1;
    }
    for (int i = 0; i <= list.length; i++) {
      if (list[i]!.username == targetUserName) {
        return i;
      } else {}
    }
    return -1;
  }

  List<UserModel?> quickSortScore(List<UserModel?> list) {
    if (list.length <= 1) {
      return list;
    } else {
      UserModel pivot = list[0]!;
      List<UserModel?> lessThanPivot = [];
      List<UserModel?> equalToPivot = [];
      List<UserModel?> greaterThanPivot = [];

      for (UserModel? element in list) {
        if (element!.score! < pivot.score!) {
          lessThanPivot.add(element);
        } else if (element.score! == pivot.score) {
          equalToPivot.add(element);
        } else {
          greaterThanPivot.add(element);
        }
      }

      return [
        ...quickSortScore(greaterThanPivot),
        ...equalToPivot,
        ...quickSortScore(lessThanPivot),
      ];
    }
  }
}
