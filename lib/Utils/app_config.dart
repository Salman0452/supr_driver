import 'dart:ui';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppConfig {
  static const appName = 'Supr Driver';

  static const supportedLanguages = ['en', 'hi'];
  static const defaultFallbackLocale = 'en';

  ///
  /// ----
  static final _box = Hive.box<dynamic>('app_config');
  static bool get isLogin => _box.get('is_login', defaultValue: false) as bool;
  static set isLogin(bool value) => _box.put('is_login', value);
  static String get appLanguageCode =>
      _box.get('app_language_code', defaultValue: defaultFallbackLocale)
          as String;
  static const limit = 5;
  static set appLanguageCode(String value) {
    _box.put('app_language_code', value);

    Get.updateLocale(Locale(value));
  }
}

enum Rating { one, two, three, four, five }
