import 'package:flutter/material.dart';
import 'package:mintsafe_wallet/config/theme/app_color.dart';

class Style {
  static ColorScheme themeData(bool isDark) {
    return ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: AppColor.primaryColor,
        onPrimary: AppColor.primaryColor,
        secondary: AppColor.secondaryColor,
        onSecondary: AppColor.secondaryColor,
        error: Colors.blue,
        onError: Colors.blue,
        background: Colors.blue,
        onBackground: Colors.blue,
        surface: AppColor.grayColor,
        onSurface: AppColor.grayColor);
  }
}
