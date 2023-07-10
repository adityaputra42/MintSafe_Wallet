import 'package:flutter/material.dart';
import 'package:mintsafe_wallet/config/theme/app_color.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        primary: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
        onPrimary: isDarkTheme ? Colors.white : Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.white,
        error: AppColor.redColor,
        onError: AppColor.textDark,
        background: isDarkTheme ? AppColor.bgDark : AppColor.bgLight,
        onBackground: isDarkTheme ? Colors.white : const Color(0xFFf9fcff),
        surface: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        onSurface: isDarkTheme ? AppColor.textDark : AppColor.textLight,
      ),
      useMaterial3: false,
      scaffoldBackgroundColor:
          isDarkTheme ? AppColor.bgDark : AppColor.bgLight,
      primarySwatch: Colors.teal,
      primaryColor: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
      indicatorColor:  isDarkTheme ? AppColor.textDark : AppColor.textLight,
      hintColor: isDarkTheme ? AppColor.grayColor : AppColor.grayColor,
      highlightColor:
          isDarkTheme ? const Color(0xff334155) : AppColor.primaryColor,
      hoverColor: isDarkTheme ? Colors.black12 : Colors.white12,
      focusColor: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
      
      
      disabledColor:
          isDarkTheme ? AppColor.grayColor : AppColor.grayColor,
      fontFamily: "Poppins",
      splashColor:
          isDarkTheme ? const Color(0xFF1F1F1F) : const Color(0xffEEF0F4),
      cardColor: isDarkTheme ? const Color(0xFF1F1F1F) : Colors.white,
      canvasColor:
          isDarkTheme ? const Color(0xff4E5157) : AppColor.grayColor,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: AppBarTheme(
          elevation: 0.5,
          backgroundColor: isDarkTheme ? AppColor.bgDark : AppColor.bgLight),
    );
  }
}
