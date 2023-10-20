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
  final mnemonicEncrypted = Ecryption().encrypt(mnemonic);
  final privateKeyEncrypted = Ecryption().encrypt(
    account['private_key']!,
  );

  Address address = Address(
      name: "Account",
      address: account['address'],
      mnemonic: mnemonicEncrypted,
      balance: 0,
      selectedAddress: true,
      privateKey: privateKeyEncrypted);
  return address;
}

class ImportWalletController extends GetxController {
  var isLoading = false.obs;
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var sheedPharse = TextEditingController();

  var buttonImport = true.obs;
  var strengthPassword = ''.obs;
  var isPasswordHide = true.obs;
  var isConfirmHide = true.obs;
  var isAggree = false.obs;
  var formKey = GlobalKey<FormState>();
  var strength = 0.0.obs;
  var color = AppColor.redColor.obs;
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

  void onChangeConfirm(String value) {
    checkButton();
  }

  void onChangePharse(String value) {
    checkButton();
  }

  void onChangePassword(String value) {
    String password = value.trim();

    if (password.isEmpty) {
      strength.value = 0;
      color.value = AppColor.redColor;
    } else if (password.length < 6) {
      strengthPassword.value = 'Weak';
      strength.value = 0.25;
      color.value = AppColor.redColor;
    } else if (password.length < 10) {
      strengthPassword.value = 'Good';
      strength.value = 0.5;
      color.value = AppColor.yellowColor;
    } else if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
      strengthPassword.value = 'Strength';
      color.value = AppColor.primaryColor;
      strength.value = 0.75;
    } else {
      strengthPassword.value = 'Very Strength';
      color.value = AppColor.primaryColor;
      strength.value = 1;
    }
    checkButton();
    onValidatePassword(confirmPassword.text);
  }

  changeHidePassword() => isPasswordHide.value = !isPasswordHide.value;
  changeHideConfirm() => isConfirmHide.value = !isConfirmHide.value;
  changeAggrement(bool value) {
    isAggree.value = value;
    checkButton();
  }

  String? onValidatePassword(String? value) {
    if (value == '') {
      return "Password can't be empty";
    } else {
      return null;
    }
  }

  String? onValidatePharse(String? value) {
    if (value == '') {
      return "Secret pharse can't be empty";
    } else {
      return null;
    }
  }

  String? onValidateConfirm(String? value) {
    if (value != password.text) {
      return "Password didn't match";
    }
    if (value == '') {
      return "Confrim password can't be empty";
    }

    return null;
  }

  void checkButton() {
    if (sheedPharse.text != '' &&
        password.text != '' &&
        confirmPassword.text != '' &&
        password.text == confirmPassword.text &&
        strength.value >= 0.5 &&
        isAggree.value) {
      buttonImport.value = false;
    } else {
      buttonImport.value = true;
    }
  }
}
