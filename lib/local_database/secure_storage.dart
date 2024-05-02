import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SecureStorage {
  static FlutterSecureStorage storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  static Future<String?> readData(String key) async {
    final result = await storage.read(key: key);
    return result;
  }
static Future<bool?> readBool(String key) async {
    final result = await storage.read(key: key);
    if (result != null) {
     
      return result.toLowerCase() == 'true';
    }
   
    return null;
  }

  static Future<void> writeBool(String key, bool value) async {
  
    await storage.write(key: key, value: value.toString());
  }

  static Future<void> writeData(String key, String value) async {

      await storage.write(key: key, value: value);
   
  }

  static Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }
}


class BoolSharedPreferences {
  static Future<bool?> readBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> writeBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<void> deleteBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}