import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:memfast/firebase_options.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StartGame {
  StartGame._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
      await PackageInfo.fromPlatform();
     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   MobileAds.instance.initialize();

   
    
  }
}
