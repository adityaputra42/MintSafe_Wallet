import 'package:flutter/material.dart';

import '../../config/config.dart';

class WidgetHelper {
  static appBar({
    required Widget title,
    required BuildContext context
  }) {
    return AppBar(
      elevation: 1,
      shadowColor: AppColor.grayColor.withOpacity(0.2),
      title: title,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.background
      // toolbarHeight: height,
    );
  }
}
