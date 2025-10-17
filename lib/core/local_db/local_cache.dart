// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  late final SharedPreferences storage;

  Future<void> init() async {
    storage = await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    storage.setString(key, value);
  }

  String? getString(String key) {
    return storage.getString(key);
  }

  void setBool(String key, bool value) {
    storage.setBool(key, value);
  }

  bool getBool(String key) {
    return storage.getBool(key) ?? false;
  }

  void setStringList(String key, List<String> value) {
    storage.setStringList(key, value);
  }

  List<String> getStringList(String key) {
    return storage.getStringList(key) ?? [];
  }

  void setMap(String key, Map<String, dynamic> value) {
    storage.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? getMap(String key) {
    final data = storage.getString(key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  void clearAllStorage() {
    storage.clear();
  }
}
