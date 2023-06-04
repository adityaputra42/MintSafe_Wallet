import 'package:flutter/material.dart';

class AppGradient {
  static const LinearGradient background = LinearGradient(
      colors: [Color(0xffF5F4FD), Color(0xFFE0F5FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  static const LinearGradient secondaryButton = LinearGradient(
      colors: [Color(0xffFFFFFF), Color(0xFFD8F3FF)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
