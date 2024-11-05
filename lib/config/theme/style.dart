import 'package:flutter/material.dart';

import '../config.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        primary: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
        onPrimary: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        secondary: AppColor.secondaryColor,
        onSecondary: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        error: AppColor.redColor,
        onError: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        surface: isDarkTheme ? AppColor.bgDark : AppColor.bgLight,
        onSurface: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        onSurfaceVariant: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        surfaceContainerHighest:
            isDarkTheme ? AppColor.textDark : AppColor.textLight,
        surfaceTint: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        onInverseSurface: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        inverseSurface: isDarkTheme ? AppColor.textDark : AppColor.textLight,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: isDarkTheme ? AppColor.bgDark : AppColor.bgLight,
      primarySwatch: Colors.teal,
      primaryColor: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
      indicatorColor: isDarkTheme ? AppColor.textDark : AppColor.textLight,
      hintColor: isDarkTheme ? AppColor.grayColor : AppColor.grayColor,
      highlightColor: isDarkTheme ? AppColor.grayColor : AppColor.grayColor,
      hoverColor: isDarkTheme ? Colors.black12 : Colors.white12,
      focusColor: isDarkTheme ? AppColor.primaryColor : AppColor.primaryColor,
      disabledColor: isDarkTheme ? AppColor.grayColor : AppColor.grayColor,
      fontFamily: "IbmPlexSans",
      datePickerTheme: DatePickerThemeData(
        shadowColor: AppColor.grayColor,
        backgroundColor: isDarkTheme ? AppColor.bgDark : AppColor.bgLight,
        surfaceTintColor: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        headerBackgroundColor:
            isDarkTheme ? AppColor.cardDark : AppColor.cardLight,
        headerHeadlineStyle: AppFont.medium12.copyWith(
            color: isDarkTheme ? AppColor.textDark : AppColor.textLight),
        headerHelpStyle: AppFont.medium12.copyWith(
            color: isDarkTheme ? AppColor.textDark : AppColor.textLight),
        headerForegroundColor:
            isDarkTheme ? AppColor.textDark : AppColor.textLight,
        yearStyle: AppFont.medium12.copyWith(
            color: isDarkTheme ? AppColor.textDark : AppColor.textLight),
        dayStyle: AppFont.medium12.copyWith(
            color: isDarkTheme ? AppColor.textDark : AppColor.textLight),
        weekdayStyle: AppFont.medium12.copyWith(
            color: isDarkTheme ? AppColor.textDark : AppColor.textLight),
        dividerColor: isDarkTheme ? AppColor.textDark : AppColor.textLight,
        dayForegroundColor: WidgetStateColor.resolveWith((states) {
          return isDarkTheme ? AppColor.textDark : AppColor.textLight;
        }),
        dayOverlayColor: WidgetStateColor.resolveWith((states) {
          return isDarkTheme ? AppColor.textDark : AppColor.textLight;
        }),
        yearForegroundColor: WidgetStateColor.resolveWith((states) {
          return isDarkTheme ? AppColor.textDark : AppColor.textLight;
        }),
      ),
      splashColor:
          isDarkTheme ? const Color(0xFF1F1F1F) : const Color(0xffEEF0F4),
      cardColor: isDarkTheme ? AppColor.cardDark : AppColor.cardLight,
      canvasColor: isDarkTheme ? AppColor.grayColor : AppColor.grayColor,
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
