import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const themeStatus = "THEMESTATUS";
  var phoneTheme =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    bool isDarkMode = phoneTheme == Brightness.dark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? isDarkMode;
  }
}
