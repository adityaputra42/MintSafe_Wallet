import 'dart:convert';

import 'package:flutter/material.dart';
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

  shortAddress({required String address, int length = 4}) {
    if (address != '') {
      return "${address.substring(0, length)}...${address.substring(address.length - length)}";
    } else {
      return '';
    }
  }

  Future<void> pasteFromClipboard(TextEditingController controller) async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData != null && clipboardData.text != null) {
      controller.text = clipboardData.text!;
    }
  }

Uint8List convertBase64ToUint8List(String base64String) {
  List<int> byteList = base64Decode(base64String);
  Uint8List uint8List = Uint8List.fromList(byteList);
  return uint8List;
}

String convertUint8ListToString(Uint8List uint8List) {
  String base64String = base64Encode(uint8List);
  return base64String;
}

bool isURL(String text) {
  // Regular expression pattern to match a URL
  RegExp urlRegex = RegExp(
    r'^(?:http|https):\/\/[\w\-]+(?:\.[\w\-]+)+(?:[\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$',
    caseSensitive: false,
    multiLine: false,
  );

  return urlRegex.hasMatch(text);
}

}
