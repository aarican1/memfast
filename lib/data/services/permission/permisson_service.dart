import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

final class PermissionService {
  Future<void> requestAdvertisingId() async {
    if (Platform.isIOS) {
      final status = await Permission.appTrackingTransparency.request();
      if (status.isGranted) {
        return;
      }
    }
  }
}
