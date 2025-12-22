import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:memfast/data/services/network_change_manage/network_change_enum_extensions.dart';

abstract class INetworkChangeManager {
  Future<NetworkChangeResults> checkFirstTime();
  void handleNetworkChange(
      void Function(NetworkChangeResults results) onChange);
  void dispose();
}

class NetworkChangeManager extends INetworkChangeManager {
  late final Connectivity connectivity;
  StreamSubscription<List<ConnectivityResult>>? subscription;

  NetworkChangeManager() {
    connectivity = Connectivity();
  }

  @override
  Future<NetworkChangeResults> checkFirstTime() async {
    var connectivityResults = await connectivity.checkConnectivity();
    return NetworkChangeResultsExtension.checkResults(
        connectivityResults.first);
  }

  @override
  void dispose() {
    subscription?.cancel();
  }

  @override
  void handleNetworkChange(
      void Function(NetworkChangeResults results) onChange) {
    subscription = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> event) {
      onChange.call(NetworkChangeResultsExtension.checkResults(event.first));
    });
  }
}
