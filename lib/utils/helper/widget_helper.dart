import 'package:flutter/material.dart';

import '../../config/config.dart';

class WidgetHelper {
  static appBar({
    required Widget title,
  }) {
    return AppBar(
      elevation: 1,
      shadowColor: AppColor.grayColor.withOpacity(0.2),
      title: title,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColor.bgDark,
      // toolbarHeight: height,
    );
  }
}
