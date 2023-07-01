import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import '../repository/repository.dart';
import 'db_controller.dart';

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
  DBController db = Get.find();

  var createdAddress = Address().obs;
  var stepIndex = 0.obs;
  var randomMnemonic = [].obs;
  var mnemonicText = ''.obs;

  var confirmValue = ''.obs;
  var randomValue = 1.obs;
  var isLoading = false.obs;
  RxList<Map<String, dynamic>> mnemonic = <Map<String, dynamic>>[].obs;

  void changeStep(int index) => stepIndex.value = index;

  void setRandom() {
    randomMnemonic.value = mnemonic.toList()
      ..shuffle()
      ..sublist(0, 6);
    randomValue.value = randomMnemonic[Random().nextInt(6)]['id'];
  }

  void changeCurrentSeedPharse() async {
    if (confirmValue.value != '') {
      if (confirmValue.value ==
          mnemonic.singleWhere(
              (element) => element['id'] == (randomValue.value))['data']) {
        // currentConfirmSeedPharse.value++;
        setRandom();
        confirmValue.value = '';

        // if (currentConfirmSeedPharse.value >= 3) {
        //   await saveNewWallet();
        //   print("ADDRESS SAVED");
        // }
      } else {
        setRandom();
        confirmValue.value = '';
      }
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

    return wordList;
  }

  Future<Address> saveNewWallet() async {
    isLoading.value = true;
    var address = await compute(saveAddressCompute, mnemonicText.value);

    // await db.setPassword(Password(password: password.text));
    await db.addAddress(address);

    createdAddress.value = address;
    isLoading.value = false;
    return address;
  }
}
