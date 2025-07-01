abstract class SharedPreferenceService {
  Future<void> init();
  String? getString(String key);

  Future<void> setString(String key, String value);

  int? getInt(String key);

  bool containsKey(String key);

  void remove(String key);
}
