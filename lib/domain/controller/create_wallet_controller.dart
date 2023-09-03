import 'dart:convert';
import 'dart:math';

// import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/succes_create_wallet.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../utils/utils.dart';
import '../repository/repository.dart';
import 'dart:developer' as dev;

Future<Address> saveAddressCompute(String mnemonic) async {
  var account = WalletRepository().getAccountInfo(mnemonic);
  final mnemonicEncryted = encrypter.encrypt(mnemonic, iv: iv);
  final privateKeyEncryted = encrypter.encrypt(account['private_key']!, iv: iv);

  Address address = Address(
      name: "Account",
      address: account['address'],
      mnemonic: mnemonicEncryted.base64.toString(),
      balance: 0,
      selectedAddress: true,
      privateKey: privateKeyEncryted.base64.toString());

  return address;
}

class CreateWalletController extends GetxController {
  var isPasswordHide = true.obs;
  var isConfirmHide = true.obs;
  var isAggree = false.obs;

  var strengthPassword = ''.obs;
  var color = AppColor.redColor.obs;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  var validatePassword = false.obs;
  var confirmValidate = ''.obs;
  var buttonPassword = true.obs;

  var createdAddress = Address().obs;
  var stepIndex = 0.obs;
  var randomMnemonic = [].obs;
  var mnemonicText = ''.obs;

  var confirmValue = ''.obs;
  var randomValue = 1.obs;
  var isLoading = false.obs;
  RxList<Map<String, dynamic>> mnemonic = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> confirmPharse = <Map<String, dynamic>>[].obs;

  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  @override
  void onInit() {
    mnemonic.value = generateMnemonic();
    super.onInit();
  }

  changeHidePassword() => isPasswordHide.value = !isPasswordHide.value;
  changeHideConfirm() => isConfirmHide.value = !isConfirmHide.value;
  changeAggrement(bool value) {
    isAggree.value = value;
    checkButton();
  }

  void changeStep(int index) => stepIndex.value = index;

  void setRandom() {
    randomMnemonic.value = mnemonic.toList()..shuffle();
    randomValue.value = randomMnemonic[Random().nextInt(12)]['id'];
  }

  validatePharse() {
    confirmPharse.sort((a, b) => a['id'].compareTo(b['id']));
    dev.log("confirm => $confirmPharse");
    dev.log("origin ==> $mnemonic");
    var listOrigin = jsonEncode(mnemonic);
    var listConfirm = jsonEncode(confirmPharse);
    dev.log((listOrigin == listConfirm).toString());

    if (listOrigin == listConfirm) {
      saveNewWallet();
      Get.to(() => SuccesCreateWallet(address: createdAddress.value));
    } else {
      Get.snackbar("Fail", "Pharse Didn't Match",
          backgroundColor: AppColor.redColor, colorText: AppColor.textDark);
      confirmPharse.clear();
      setRandom();
    }
  }

  void onAccept(String value, {int? id}) {
    setConfrimPharse(id: id ?? 0, text: value);
  }

  void setConfrimPharse({required int id, required String text}) {
    if (!confirmPharse.any((element) => element['id'] == id) ||
        confirmPharse.isEmpty) {
      confirmPharse.add({"id": id, "data": text});
      randomMnemonic.removeWhere((element) => element['data'] == text);
    }
  }

  List<Map<String, dynamic>> generateMnemonic() {
    String mnemonic = WalletRepository().generateMnemonic();
    mnemonicText.value = mnemonic;
    final words = mnemonic.replaceAll(" ", ",").split(',');
    List<Map<String, dynamic>> wordList = [];
    for (int i = 0; i < words.length; i++) {
      wordList.add({"id": i + 1, "data": words[i]});
    }
    dev.log("Menemonic => $wordList");
    return wordList;
  }

  Future<Address> saveNewWallet() async {
    isLoading.value = true;
    var address = await compute(saveAddressCompute, mnemonicText.value);

    await DbHelper.instance.setPassword(Password(password: password.text));
    await DbHelper.instance.addAddress(address);

    createdAddress.value = address;
    isLoading.value = false;
    return address;
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
