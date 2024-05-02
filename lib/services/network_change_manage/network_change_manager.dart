import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:memfast/services/network_change_manage/network_change_enum_extensions.dart';

abstract class INetworkChangeManager {
  Future<NetworkChangeResults> checkFirstTime();
  void handleNetworkChange(
      void Function(NetworkChangeResults results) onChange);
  void dispose();
}

class NetworkChangeManager extends INetworkChangeManager {
  late final connectivity;
  StreamSubscription<ConnectivityResult>? subscription;

  NetworkChangeManager() {
    connectivity = Connectivity();
  }
  @override
  Future<NetworkChangeResults> checkFirstTime() async {
    var connectvityResults = await (connectivity.checkConnectivity());
    return NetworkChangeResultsExtension.checkResults(connectvityResults);
  }

  @override
  void dispose() {
    subscription?.cancel();
  }

  @override
  void handleNetworkChange(
      void Function(NetworkChangeResults results) onChange) {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      onChange.call(NetworkChangeResultsExtension.checkResults(event));
    });
  }
}