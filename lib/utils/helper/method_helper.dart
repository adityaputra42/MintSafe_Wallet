import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../config/config.dart';

class MethodHelper {
  handleCopy({
    required String data,
  }) async {
    await Clipboard.setData(ClipboardData(text: data)).then((_) => Get.snackbar(
        "Success", "copy successfully",
        backgroundColor: AppColor.primaryColor, colorText: AppColor.textDark));
  }
}