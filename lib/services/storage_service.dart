import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }

  static saveString({required String key, required String value}) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(key, value);
  }

  static saveBool({required String key, required bool value}) async {
    final storage = await SharedPreferences.getInstance();
    storage.setBool(key, value);
  }

  static Future<bool> getBool({required String key}) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getBool(key) ?? false;
  }

  static Future<String?> get({required String key}) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }
}
