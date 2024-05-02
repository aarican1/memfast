import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/local_database/secure_storage.dart';

import 'package:memfast/models/user_model.dart';
import 'package:memfast/pages/select_level/state/select_level_state.dart';
import 'package:memfast/utility/exceptions/enums/firebase_enums.dart';

class SelectLevelCubit extends Cubit<SelectLevelState> {
  SelectLevelCubit()
      : super(const SelectLevelState(
          openLockLevel: 1,
        )) {
    Future.microtask(() => fetchOpenLockLevelInfo());
  }
  Future<void> fetchOpenLockLevelInfo() async {
    final String? username = await SecureStorage.storage.read(key: 'username');
    if (username == null || username.isEmpty) {}
    try{
    final result = MyFirebaseCollectionEnum.users.references;
    final userSnapshot =
        await result.where('username', isEqualTo: username).get();
    if (userSnapshot.docs.isNotEmpty) {
      final userData = userSnapshot.docs.first.data() as Map<String, dynamic>;

      final UserModel user = const UserModel().fromJson(userData);
      final int? openLockLevel = user.openLockLevel;

      emit(state.copyWith(openLockLevel: openLockLevel));
    }}catch(e){
       emit(state.copyWith(errorMessage: '$e'));
    }
  }

  Future<void> choiceButtonColor() async {
    await fetchOpenLockLevelInfo();
    List<bool>? openLevelList;

    if (state.openLockLevel < 0 || state.openLockLevel > 4) {
      emit(state.copyWith(openLockLevel: 1));
    }
    if (state.openLockLevel == 1) {
      openLevelList = [true, false, false,false];
    } else if (state.openLockLevel == 2) {
      openLevelList = [true, true, false,false];
    } else if (state.openLockLevel==3){
      openLevelList = [true, true, true,false];
    }else{
      openLevelList= [true, true, true,true];
    }

    emit(state.copyWith(openLevelList: openLevelList));
  }
   void errorMakeNull() {
    emit(state.copyWith(errorMessage: null));
  }
}
