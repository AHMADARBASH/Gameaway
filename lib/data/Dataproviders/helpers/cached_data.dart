import 'package:shared_preferences/shared_preferences.dart';

class CachedData {
  static late SharedPreferences _prefrences;
  static Future init() async =>
      _prefrences = await SharedPreferences.getInstance();

  static void saveData({key, data}) async {
    await _prefrences.setString(key, data);
  }

  static String? getData({key}) {
    return _prefrences.getString(key);
  }

  static bool containsKey(key) {
    return _prefrences.containsKey(key);
  }
}
