import 'package:flutter/material.dart';

import '../../config/config.dart';

class WidgetHelper {
  static appBar({
    required Widget title,
  }) {
    return AppBar(
     
      title: title,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: AppColor.bgDark,
    );
  }
}
