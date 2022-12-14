import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:mprc/helper/models/user_model.dart';

class Prefs {
  final String _THEME_KEY = "THEME";
  final String _USER_KEY = "USER";
  late final GetStorage _storage;

  Prefs() {
    _storage = GetStorage();
  }

  Future<void> setTheme(bool isLight) async {
    await _storage.write(_THEME_KEY, isLight);
  }

  Future<bool> getTheme() async {
    var isLight = _storage.read<bool>(_THEME_KEY);
    return isLight ?? false;
  }

  Future<void> setUser(UserModel user) async {
    await _storage.write(_USER_KEY, jsonEncode(user));
  }

  Future<UserModel> getUser() async {
    var user = _storage.read<String>(_USER_KEY);
    if (user != null) {
      return UserModel.fromJson(jsonDecode(user));
    } else {
      return UserModel();
    }
  }

  Future<void> clearUser() async {
    await _storage.remove(_USER_KEY);
  }
}
