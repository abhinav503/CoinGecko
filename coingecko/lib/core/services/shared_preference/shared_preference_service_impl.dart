import 'package:coingecko/core/services/shared_preference/shared_preference_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServiceImpl extends SharedPreferenceService {
  static late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  @override
  String? getString(String key) {
    return _prefs.getString(key);
  }

  @override
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
