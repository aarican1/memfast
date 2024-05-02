import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:memfast/local_database/secure_storage.dart';
import 'package:memfast/pages/splash/bloc/state/splash_state.dart';

import 'package:memfast/utility/exceptions/enums/firebase_enums.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(const SplashState(
            isVersionOk: false, isLogIn: false, isFirabaseOk: false)) {
    _initialize();
  }

  Future<void> _initialize() async {
    await getSecureStorage();
    await fetchUpdateUrl();
    await getVersionDatabase();
  }
 void errorMakeNull() {
    emit(state.copyWith(errorMessage: null));
  }
  Future<void> getSecureStorage() async {
    String key = 'username';

    String? result = await SecureStorage.readData(key);
   
    if (result == null || result.isEmpty) {
      emit(state.copyWith(isLogIn: false));
    } else {
      emit(state.copyWith(isLogIn: true));
    }
  }

  Future<void> getVersionDatabase() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String clientVersion = packageInfo.version;

    if (clientVersion.isEmpty) {
      emit(state.copyWith(errorMessage: 'Client version is null'));
    } else {
      emit(state.copyWith(clientVersion: clientVersion));
    
    }

   
    if (kIsWeb) {
     
    }

    final firestore = FirebaseFirestore.instance;
    final verRef = firestore.collection('version');
    final DocumentSnapshot<Map<String, dynamic>> response =
        await verRef.doc('android').get();

    if (!response.exists) {
       emit(state.copyWith(errorMessage: 'This document is not find'));
      //throw Exception('*********Belge bulunamadı***********');
    }
    if (response.data()?['number'] == null || response.data()?['number'] == '') {
      emit(state.copyWith(errorMessage: '${response.data()?['number']} is null'));
     // throw CustomFirebaseException(
       //   description: '${response.data()?['number']} is null');
    } else {
      emit(state.copyWith(databaseVersion: response.data()!['number']));
      versionParse(state.clientVersion!, state.databaseVersion!);
    }
  }

  Future<void> versionParse(String appVersion, String databaseVersion) async {
    if (databaseVersion.isEmpty && appVersion.isEmpty) {
      emit(state.copyWith(errorMessage: 'version get error:$appVersion or $databaseVersion is null'));
     /* throw CustomFirebaseException(
          description:
              'version get error:$appVersion or $databaseVersion is null');*/
    }

    final appNumberConverted = appVersion.split('.').join();
    final databaseNumberConverted = databaseVersion.split('.').join();
    final int? deviceNumber = int.tryParse(appNumberConverted);
    final int? databaseNumber = int.tryParse(databaseNumberConverted);

    if (deviceNumber == null && databaseNumber == null) {
       emit(state.copyWith(errorMessage: 'version get error:$appVersion or $databaseVersion is not vaild parse'));
      /*throw CustomFirebaseException(
          description:
              'version get error:$appVersion or $databaseVersion is not vaild parse');*/
    }

    if (deviceNumber! >= databaseNumber!) {
      emit(state.copyWith(isVersionOk: true, isFirabaseOk: true));
    } else {
      emit(state.copyWith(isVersionOk: false, isFirabaseOk: true));
    }
  }

  Future<void> fetchUpdateUrl() async {
    final urlReferences = MyFirebaseCollectionEnum.urls.references;
    try {
      final urlSnapshot = await urlReferences.doc('update_url').get();
      if (urlSnapshot.exists) {
        final urlData = urlSnapshot['url'];
        final url = urlData.toString();

     
        if (url.isEmpty) {
          throw 'url is null';
        }
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          emit(state.copyWith(updateUri: uri));
        }
      }
    } catch (e) {
       emit(state.copyWith(errorMessage: '$e'));
     // throw Exception('$e');
    }
  }

  Future<void> launchUpdateUrl() async {
    final uriParse = state.updateUri;
    if (uriParse == null) {
       emit(state.copyWith(errorMessage: '$uriParse is null'));
      //throw CustomFirebaseException(description: '$uriParse is null');
    }

    if (await canLaunchUrl(uriParse!)) {
      await launchUrl(uriParse, mode: LaunchMode.externalNonBrowserApplication);
    } else {
       emit(state.copyWith(errorMessage: 'Could not launch $uriParse'));
      //throw 'Could not launch $uriParse';
    }
  }
}
