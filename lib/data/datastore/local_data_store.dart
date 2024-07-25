import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStore {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> getSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<void> setBool(String key, bool value) async {
    final dataStore = await getSharedPreferences();
    await dataStore.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final dataStore = await getSharedPreferences();
    return dataStore.getBool(key) ?? false;
  }

Future<void> setString(String key, String value) async {
    final dataStore = await getSharedPreferences();
    await dataStore.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final dataStore = await getSharedPreferences();
    return dataStore.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    final dataStore = await getSharedPreferences();
    await dataStore.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final dataStore = await getSharedPreferences();
    return dataStore.getInt(key);
  }

  Future<void> setData(String key, dynamic data) async {
    final dataStore = await getSharedPreferences();
    await dataStore.setString(key, jsonEncode(data));
  }

  Future<dynamic> getData(String key) async {
    final dataStore = await getSharedPreferences();
    final data = dataStore.getString(key);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future<void> setStringList(String key, List<String> value) async {
    final dataStore = await getSharedPreferences();
    await dataStore.setStringList(key, value);
  }

  Future<List<String>> getStringList(String key) async {
    final dataStore = await getSharedPreferences();
    return dataStore.getStringList(key) ?? [];
  }

  Future<void> clear() async {
    final dataStore = await getSharedPreferences();
    dataStore.getKeys().forEach((key) {
      dataStore.remove(key);
    });
  }
}

