import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/helper/db_helper.dart';

import '../../config/config.dart';
import '../../utils/helper/helper.dart';

class SecurityPrivasyController extends GetxController {
  var selectedSheedPharse = 0.obs;
  var isValid = false.obs;
  var isObsecure = true.obs;
  var privateKeySelected = ''.obs;
  var mnemonicSelected = ''.obs;

  TextEditingController passwordController = TextEditingController();
  final EvmNewController evmController = Get.find();

  void changeSheedPharse(int index) => selectedSheedPharse.value = index;

  void inactiveStateSheedPharse() {
    isValid.value = false;
    passwordController.clear();
  }

  void changeObsecure() => isObsecure.value = !isObsecure.value;
  void validatePasswordMnmonic() async {
   final password = await DbHelper.instance.getPassword();
    if (passwordController.text == password.password) {
      // privateKeySelected.value = encrypter
      //     .decrypt(evmController.selectedAddress.value.privateKey!, iv: iv);
      final mnemonic =
          Ecryption().decrypt(evmController.selectedAddress.value.mnemonic!);
      mnemonicSelected.value = mnemonic;
      print("===========>");
      print(evmController.selectedAddress.value.mnemonic!);
      print("===========>");
      print(mnemonic);
      isValid.value = true;
    } else {
      Get.snackbar("Gagal", "password didn't match",
          backgroundColor: AppColor.redColor);
      isValid.value = false;
      passwordController.clear();
    }
  }

  void validatePasswordPrivateKey() async {
     final password =  await DbHelper.instance.getPassword();
    if (passwordController.text == password.password) {
      // privateKeySelected.value = encrypter
      //     .decrypt(evmController.selectedAddress.value.privateKey!, iv: iv);
      final privateKey =
          Ecryption().decrypt(evmController.selectedAddress.value.privateKey!);
      privateKeySelected.value = privateKey;

      print("===========>");
      print(evmController.selectedAddress.value.privateKey!);
      print("===========>");
      print(privateKey);
      isValid.value = true;
    } else {
      Get.snackbar("Gagal", "password didn't match",
          backgroundColor: AppColor.redColor);
      isValid.value = false;
      passwordController.clear();
    }
  }
}
