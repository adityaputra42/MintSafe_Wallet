import 'package:flutter/material.dart';

import '../../config/config.dart';

class WidgetHelper {
  static appBar({
    required Widget title,
  }) {
    return AppBar(
      elevation: 2,
      shadowColor: AppColor.primaryColor.withOpacity(0.25),
      title: title,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColor.bgDark,
    );
  }
}
