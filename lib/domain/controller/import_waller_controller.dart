import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../utils/utils.dart';
import '../../view/pages/page.dart';
import '../repository/repository.dart';
import 'db_controller.dart';

Future<Address?> importMnemonic(String mnemonic) async {
  // await db.setPassword(Password(password: password));

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
  // print(address.address);
  // print(address.mnemonic);
  // print(address.privateKey);

  // await db.addAddress(address);

  // Get.offAll(() => MainPage(address: address));
  return address;
}

class ImportWalletController extends GetxController {
  final DBController db = Get.find();
  var isLoading = false.obs;
  var passwordController = TextEditingController();

  void import(String mnemonic) async {
    isLoading.value = true;
    if (WalletRepository().validateMnemonic(mnemonic)) {
      await db.setPassword(Password(password: passwordController.text));

      var address = await compute(importMnemonic, mnemonic);

      // var account = WalletRepository().getAccountInfo(mnemonic);
      // final mnemonicEncrypted = encrypter.encrypt(mnemonic, iv: iv);
      // final privateKeyEncrypted =
      //     encrypter.encrypt(account['private_key']!, iv: iv);

      // Address address = Address(
      //     name: "Account",
      //     address: account['address'],
      //     mnemonic: mnemonicEncrypted.base64.toString(),
      //     balance: 0,
      //     selectedAddress: true,
      //     privateKey: privateKeyEncrypted.base64.toString());
      // print(address.address);
      // print(address.mnemonic);
      // print(address.privateKey);

      await db.addAddress(address!);

      Get.offAll(() => MainPage(address: address));
    } else {
      isLoading.value = false;
      Get.snackbar('Error', "Invalid seed pharse",
          colorText: AppColor.textDark, backgroundColor: AppColor.redColor);
    }
  }
}
