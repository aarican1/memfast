import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memfast/pages/network_change/bloc/network_change_state.dart';
import 'package:memfast/services/network_change_manage/network_change_enum_extensions.dart';

import 'package:memfast/services/network_change_manage/network_change_manager.dart';

class NetworkChangeCubit extends Cubit<NetworkChangeState> {
  NetworkChangeCubit()
      : super(const NetworkChangeState( isFirstCheck: false,
            networkChangeResults: NetworkChangeResults.off)) {
    fetchFirstResults();
    initState();
  }

  final INetworkChangeManager changeManager = NetworkChangeManager();

  void initState() {
    changeManager.handleNetworkChange((results) {
      emit(state.copyWith(networkChangeResults: results, isFirstCheck: false));
    });
  }

  Future<void> fetchFirstResults() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final results = await changeManager.checkFirstTime();
      emit(state.copyWith(networkChangeResults: results, isFirstCheck: true));
    });
  }
}
