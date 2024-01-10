import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hh_express/helpers/extentions.dart';

import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/settings/globals.dart';

class LocalStorage {
  static final _storage = new FlutterSecureStorage();
  static String? get getToken => _token;

  static String? _token;

  static Future<void> init() async {
    final myToken = await _storage.read(key: LocalDataKeys.token.name);
    _token = myToken;
    await _setMyLang();
    _langSaver();
  }

  static Future<void> saveToken(String token) async {
    final newData =
        await _storage.write(key: LocalDataKeys.token.name, value: token);
    _token = token;
  }

  static Future<void> deleteToken() async {
    _token = null;
    await _storage.delete(key: LocalDataKeys.token.name);
  }

  static Future<void> _setMyLang() async {
    final myLang = await _storage.read(key: LocalDataKeys.lang.name);
    '$myLang oldLang'.log();
    if (myLang != null) {
      locale.value = myLang;
    }
  }

  static void _langSaver() async {
    locale.addListener(() async {
      try {
        final newLang = locale.value;
        await _storage.write(key: LocalDataKeys.lang.name, value: newLang);

        '$newLang lang Svaed'.log();
      } catch (e) {
        'SaveLangError'.log();
      }
    });
  }

  static Future<String?> readStr(String key) async {
    return await _storage.read(key: key);
  }

  static Future<void> saveStr(
      {required String val, required String key}) async {
    return await _storage.write(key: key, value: val);
  }
}
