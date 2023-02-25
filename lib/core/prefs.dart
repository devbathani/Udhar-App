// Dart imports:
import 'dart:developer';

import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/utils/logger.dart';

class AppPrefs {
  final StreamingSharedPreferences preferences;

  AppPrefs(
    this.preferences,
  )   : fcmToken = preferences.getString(
          PrefsConstants.fcmToken,
          defaultValue: '',
        ),
        name = preferences.getString(
          PrefsConstants.name,
          defaultValue: '',
        ),
        phoneNumber = preferences.getString(
          PrefsConstants.phoneNumber,
          defaultValue: '',
        ),
        upiId = preferences.getString(
          PrefsConstants.upiId,
          defaultValue: '',
        ),
        uid = preferences.getString(
          PrefsConstants.uid,
          defaultValue: '',
        ),
        email = preferences.getString(
          PrefsConstants.email,
          defaultValue: '',
        );

  Preference<String> fcmToken;
  Preference<String> name;
  Preference<String> phoneNumber;
  Preference<String> upiId;
  Preference<String> email;
  Preference<String> uid;

  Future<bool> setBool(String key, bool value) async {
    printBefore(value: value, key: key);
    return await preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    printBefore(value: value, key: key);
    return await preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    printBefore(value: value, key: key);
    return await preferences.setInt(key, value);
  }

  Future<void> clear() async {
    await preferences.clear();
  }

  Future<bool> setString(String key, String value) async {
    printBefore(value: value, key: key);
    return await preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    printBefore(value: value, key: key);
    return await preferences.setStringList(key, value);
  }

  Future<bool> setCustomValue(
      String key, value, PreferenceAdapter<dynamic> adapter) async {
    printBefore(value: value, key: key);
    return await preferences.setCustomValue(key, value, adapter: adapter);
  }

  void printBefore({String? key, value}) =>
      log('Saving Key: $key &  value: $value');
}

class PrefsConstants {
  static const String fcmToken = 'fcmToken';
  static const String name = 'name';
  static const String phoneNumber = 'phoneNumber';
  static const String upiId = 'upiId';
  static const String email = 'email';
  static const String uid = 'uid';
}

/// Making AppPrefs injectable
Future<void> setupLocator() async {
  final preferences = await StreamingSharedPreferences.instance;
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(preferences));

  logger.w("Registering App Router");

  logger.w("Registerd App Router");
}
