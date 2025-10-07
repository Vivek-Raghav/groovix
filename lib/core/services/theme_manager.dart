// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/constants/pref_keys.dart';
import 'package:groovix/core/local_db/local_cache.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class ThemeManager extends ChangeNotifier {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal();

  final LocalCache _cache = getIt<LocalCache>();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  /// Initialize theme from cache
  Future<void> initializeTheme() async {
    final savedTheme = _cache.getString(PrefKeys.themeMode);
    if (savedTheme != null) {
      switch (savedTheme) {
        case 'light':
          _themeMode = ThemeMode.light;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          break;
        case 'system':
        default:
          _themeMode = ThemeMode.system;
          break;
      }
    }
    notifyListeners();
  }

  /// Set theme mode and save to cache
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    _cache.setString(PrefKeys.themeMode, _getThemeModeString(mode));
    notifyListeners();
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    if (_themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else {
      await setThemeMode(ThemeMode.light);
    }
  }

  /// Get theme data based on current mode
  ThemeData getThemeData(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return lightTheme(context);
      case ThemeMode.dark:
        return darkTheme(context);
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark
            ? darkTheme(context)
            : lightTheme(context);
    }
  }

  String _getThemeModeString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  String get themeModeDisplayName {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  IconData get themeModeIcon {
    switch (_themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}
