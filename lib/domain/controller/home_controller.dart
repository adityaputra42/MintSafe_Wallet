import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../utils/helper/helper.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;

  final passwordTextController = TextEditingController();
  final isLoadingLogin = false.obs;
  final obsecurePassword = true.obs;
  final buttonDiasable = true.obs;
  void onChangeTabIndex(int index) => tabIndex.value = index;

  changeObesure() {
    obsecurePassword.value = !obsecurePassword.value;
  }

  onChangePassword(String value) {
    if (passwordTextController.text != '') {
      buttonDiasable.value = false;
    } else {
      buttonDiasable.value = true;
    }
  }

  void login() async {
    isLoadingLogin.value = true;
    var password = await DbHelper.instance.getPassword();
    if (passwordTextController.text == password.password) {
      PrefHelper.instance.setLogin(true);
      Get.back();
    } else {
      Get.snackbar("Failed", "Password didn't match!",
          backgroundColor: AppColor.redColor, colorText: AppColor.textDark);
    }
    passwordTextController.clear();
    buttonDiasable.value = true;
    isLoadingLogin.value = false;
  }
}
