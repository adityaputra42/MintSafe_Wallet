import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/view/pages/setting/security/active_pharse.dart';
import 'package:mintsafe_wallet/view/pages/setting/security/active_private_key.dart';

import '../../config/config.dart';
import '../../utils/helper/helper.dart';

class SecurityPrivasyController extends GetxController {
  var selectedSheedPharse = 0.obs;
  var isLoading = false.obs;
  var isObsecure = true.obs;
  var isDisableButton = true.obs;
  var privateKeySelected = ''.obs;
  var mnemonicSelected = ''.obs;
  RxList<Map<String, dynamic>> mnemonicMap = <Map<String, dynamic>>[].obs;

  TextEditingController passwordController = TextEditingController();
  final EvmNewController evmController = Get.find();

  void changeSheedPharse(int index) => selectedSheedPharse.value = index;

  void inactiveStateSheedPharse() {
    passwordController.clear();
    mnemonicMap.clear();
    mnemonicSelected.value = '';
    Get.back();
  }

  void inactiveStatePrivateKey() {
    passwordController.clear();
    privateKeySelected.value = '';
    Get.back();
  }

  void onPasswordChange(String value) {
    if (passwordController.text != '') {
      isDisableButton.value = false;
    } else {
      isDisableButton.value = true;
    }
  }

  void changeObsecure() => isObsecure.value = !isObsecure.value;
  void validatePasswordMnmonic() async {
    isLoading.value = true;
    final password = await DbHelper.instance.getPassword();
    if (passwordController.text == password.password) {
      final mnemonic =
          Ecryption().decrypt(evmController.selectedAddress.value.mnemonic!);
      mnemonicSelected.value = mnemonic;
      final words = mnemonic.replaceAll(" ", ",").split(',');
      List<Map<String, dynamic>> wordList = [];
      for (int i = 0; i < words.length; i++) {
        wordList.add({"id": i + 1, "data": words[i]});
      }
      mnemonicMap.assignAll(wordList);
      Get.back();
      Get.to(() => ActivePhrase());
      isLoading.value = false;
    } else {
      Get.back();
      Get.snackbar("Gagal", "password didn't match",
          backgroundColor: AppColor.redColor);
      passwordController.clear();
      isLoading.value = false;
    }
  }

  void validatePasswordPrivateKey() async {
    isLoading.value = true;
    final password = await DbHelper.instance.getPassword();
    if (passwordController.text == password.password) {
      final privateKey =
          Ecryption().decrypt(evmController.selectedAddress.value.privateKey!);
      privateKeySelected.value = privateKey;
      Get.back();
      Get.to(() => ActivePrivateKey());
      isLoading.value = false;
    } else {
      Get.back();
      Get.snackbar("Gagal", "password didn't match",
          backgroundColor: AppColor.redColor);
      passwordController.clear();
      isLoading.value = false;
    }
  }
}
