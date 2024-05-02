import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkChangeResults {
  on,
  off,
}

extension NetworkChangeResultsExtension on NetworkChangeResults {
  static NetworkChangeResults checkResults(ConnectivityResult results) {
    switch (results) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.vpn:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.other:
        return NetworkChangeResults.on;

      case ConnectivityResult.none:
      default:
        return NetworkChangeResults.off;
    }
  }
}
