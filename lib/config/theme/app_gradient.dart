import 'package:flutter/material.dart';

class AppGradient {
  static const LinearGradient background = LinearGradient(colors: [
    Color(0xffF4F7FE),
        Color(0xffF4F7FE),
    // Color(0xFFE0F5FF),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  static const LinearGradient secondaryButton = LinearGradient(
      colors: [Color(0xffFFFFFF), Color(0xFFD8F3FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const LinearGradient bottomNavBar = LinearGradient(colors: [
    Color(0xffFFFFFF),
    Color(0xffFFFFFF),
    // Color(0xFFC6EDFE),
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static const LinearGradient cardETH = LinearGradient(
      colors: [Color(0xff4765FF), Color(0xFF7B88FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient cardBNB = LinearGradient(
      colors: [Color(0xffF7931A), Color(0xFFFACE31)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient cardMatic = LinearGradient(
      colors: [Color(0xff5631FA), Color(0xff627EEA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient cardARB = LinearGradient(
      colors: [Color(0xff0047FF), Color(0xFF6B94FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient cardZK = LinearGradient(
      colors: [Color(0xff282831), Color(0xFF51516A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient card = LinearGradient(
      colors: [Color(0xff3F8BAC), Color(0xFF73B0CD)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
  static const LinearGradient warning = LinearGradient(
      colors: [Color(0xffFFF6D7), Color(0xFFFFEBA5)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}

// [Color(0xff5631FA), Color(0xff627EEA)],