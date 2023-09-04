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

  var strengthPassword = 0.0.obs;
  var strength = "".obs;
  var color = AppColor.redColor.obs;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  var buttonPassword = true.obs;

  var buttonConfirmPharse = true.obs;
  var formKey = GlobalKey<FormState>();
  var createdAddress = Address().obs;
  var stepIndex = 0.obs;
  var randomMnemonic = [].obs;
  var mnemonicText = ''.obs;

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

  String? onValidatePassword(String? value) {
    if (value == '') {
      return "Password can't be empty";
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
    isLoading.value = true;
    confirmPharse.sort((a, b) => a['id'].compareTo(b['id']));

    var listOrigin = jsonEncode(mnemonic);
    var listConfirm = jsonEncode(confirmPharse);

    if (listOrigin == listConfirm) {
      saveNewWallet();
      Get.to(() => SuccesCreateWallet(address: createdAddress.value));
    } else {
      Get.snackbar("Fail", "Pharse Didn't Match",
          backgroundColor: AppColor.redColor, colorText: AppColor.textDark);
      confirmPharse.clear();
      setRandom();
    }
    isLoading.value = false;
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
    checkButtonConfirm();
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
    var address = await compute(saveAddressCompute, mnemonicText.value);

    await DbHelper.instance.setPassword(Password(password: password.text));
    await DbHelper.instance.addAddress(address);

    createdAddress.value = address;

    return address;
  }

  void onChangeConfirmPassword(String value) {
    checkButton();
  }

  void onChangePassword(String value) {
    String password = value.trim();

    if (password.isEmpty) {
      strengthPassword.value = 0;
      color.value = AppColor.redColor;
    } else if (password.length < 6) {
      strengthPassword.value = 0.25;
      strength.value = "Weak";
      color.value = AppColor.redColor;
    } else if (password.length < 10) {
      strength.value = "Good";
      strengthPassword.value = 0.5;
      color.value = AppColor.yellowColor;
    } else if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
      strengthPassword.value = 0.75;
      strength.value = "Strong";
      color.value = const Color(0xff63EEBC);
    } else {
      strengthPassword.value = 1;
      strength.value = "Very Strong";
      color.value = AppColor.primaryColor;
    }
    checkButton();
    onValidateConfirm(confirmPassword.text);
  }

  void checkButton() {
    if (password.text != '' &&
        confirmPassword.text != '' &&
        password.text == confirmPassword.text &&
        strengthPassword.value >= 0.5 &&
        isAggree.value) {
      buttonPassword.value = false;
    } else {
      buttonPassword.value = true;
    }
  }

  void checkButtonConfirm() {
    if (confirmPharse.length == 12) {
      buttonConfirmPharse.value = false;
    } else {
      buttonConfirmPharse.value = true;
    }
  }
}
