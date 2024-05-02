import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/local_database/secure_storage.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:memfast/pages/register/bloc/register_state.dart';

import 'package:memfast/utility/exceptions/enums/firebase_enums.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
      : super(const RegisterState(
            uri: null,
            isLoading: false,
            agreementUrl: '',
            isControllerValueOk: false,
            isAgreementAccept: false,
            isFirebaseOk: false,
            isAlreadyUsername: false,
            isCreateUsername: false)) {
    Future.microtask(() => fetchAgreementUrl());
  }

  Future<void> emptyUserName() async {
    emit(state.copyWith(isControllerValueOk: false));
  }

  Future<void> registerUser(String username) async {
    final userReferences = MyFirebaseCollectionEnum.users.references;
    emit(state.copyWith(isLoading: true));
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await userReferences
          .where('username', isEqualTo: username)
          .limit(1)
          .get() as QuerySnapshot<Map<String, dynamic>>;
      if (snapshot.docs.isNotEmpty) {
       

        emit(state.copyWith(
            isAlreadyUsername: true, isCreateUsername: false, isLoading: false));
      } else {
        await userReferences
            .add({'username': username, 'score': 0, 'openLockLevel': 1});

        await SecureStorage.writeData('username', username);
        await BoolSharedPreferences.writeBool('allowMusicPlay', true);
        await BoolSharedPreferences.writeBool('allowSoundPlay', true);
     
       
        emit(state.copyWith(
            isCreateUsername: true, isAlreadyUsername: false, isLoading: false));

      
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: '$e'));
    }
  }

  void acceptAgreement() {
    emit(state.copyWith(isAgreementAccept: !(state.isAgreementAccept)));
  }

  Future<void> fetchAgreementUrl() async {
    final urlReferences = MyFirebaseCollectionEnum.urls.references;
   
    try {
      final urlSnapshot = await urlReferences.doc('privacy_agreement').get();
      if (urlSnapshot.exists) {
        final urlData = urlSnapshot['url'];
        final url = urlData.toString();

      
        if (url.isEmpty) {
          throw 'url is null';
        }
        emit(state.copyWith(agreementUrl: url));
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          emit(state.copyWith(uri: uri));
        }
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: '$e'));
    }
  }
 void errorMakeNull() {
    emit(state.copyWith(errorMessage: null));
  }
  Future<void> launchUpdateUrl() async {
    final uriParse = Uri.parse(state.agreementUrl);

    if (await canLaunchUrl(uriParse)) {
      await launchUrl(uriParse, mode: LaunchMode.externalNonBrowserApplication);
    } else {
      emit(state.copyWith(errorMessage: 'Could not launch $uriParse'));
    }
  }
}
