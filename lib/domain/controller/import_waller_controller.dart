import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../utils/utils.dart';
import '../../view/pages/page.dart';
import '../repository/repository.dart';

Future<Address?> importMnemonic(String mnemonic) async {
  var account = WalletRepository().getAccountInfo(mnemonic);
  final mnemonicEncrypted = encrypter.encrypt(mnemonic, iv: iv);
  final privateKeyEncrypted =
      encrypter.encrypt(account['private_key']!, iv: iv);

  Address address = Address(
      name: "Account",
      address: account['address'],
      mnemonic: mnemonicEncrypted.base64.toString(),
      balance: 0,
      selectedAddress: true,
      privateKey: privateKeyEncrypted.base64.toString());
  return address;
}

class ImportWalletController extends GetxController {
  var isLoading = false.obs;
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var validatePassword = false.obs;
  var confirmValidate = ''.obs;
  var buttonPassword = true.obs;
  var strengthPassword = ''.obs;
  var color = AppColor.redColor.obs;
  var isAggree = false.obs;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  void import(String mnemonic) async {
    isLoading.value = true;
    if (WalletRepository().validateMnemonic(mnemonic)) {
      var address = await compute(importMnemonic, mnemonic);
      await DbHelper.instance.setPassword(Password(password: password.text));
      await DbHelper.instance.addAddress(address!);
      Get.offAll(() => MainPage(address: address));
    } else {
      isLoading.value = false;
      Get.snackbar('Error', "Invalid seed pharse",
          colorText: AppColor.textDark, backgroundColor: AppColor.redColor);
    }
  }

  void onChangeConfirmPassword(String value) {
    String data = value.trim();
    if (data.isEmpty) {
      confirmValidate.value = 'Please enter your confirm password';
      validatePassword.value = false;
    } else if (data != password.text) {
      confirmValidate.value = "Password didn't match";
      validatePassword.value = false;
    } else {
      confirmValidate.value = '';
      validatePassword.value = true;
    }
    checkButton();
  }

  void onChangePassword(String value) {
    String password = value.trim();

    if (password.isEmpty) {
      strengthPassword.value = 'Please enter your password';
      color.value = AppColor.redColor;
    } else if (password.length < 5) {
      strengthPassword.value = 'Weak';
      color.value = AppColor.redColor;
    } else if (password.length < 8) {
      strengthPassword.value = 'Good';
      color.value = AppColor.yellowColor;
    } else if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
      strengthPassword.value = 'Strength';
      color.value = AppColor.primaryColor;
    } else {
      strengthPassword.value = 'Very Strength';
      color.value = AppColor.primaryColor;
    }
    checkButton();
  }

  changeAggrement(bool value) {
    isAggree.value = value;
    checkButton();
  }

  void checkButton() {
    if (password.text != '' &&
        confirmPassword.text != '' &&
        password.text == confirmPassword.text &&
        password.text.length > 5 &&
        validatePassword.value &&
        isAggree.value) {
      buttonPassword.value = false;
    } else {
      buttonPassword.value = true;
    }
  }
}
