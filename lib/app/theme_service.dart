import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ThemeService {
  final _box = Hive.box('app_config');
  final _themeKey = 'is_dark_theme';

  bool _loadThemeFromBox() => _box.get(_themeKey, defaultValue: false);
  
  ThemeMode get themeMode => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.system;
  
  bool get isDarkMode => Get.isDarkMode;
  
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.system : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
    _updateSystemUI();
  }
  
  void setDarkMode(bool isDark) {
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.system);
    _saveThemeToBox(isDark);
    _updateSystemUI();
  }
  
  void _saveThemeToBox(bool isDarkMode) => _box.put(_themeKey, isDarkMode);
  
  void _updateSystemUI() {
    final isDark = Get.isDarkMode;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: isDark ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }
  
  void updateSystemUIForCurrentTheme() {
    _updateSystemUI();
  }
}
