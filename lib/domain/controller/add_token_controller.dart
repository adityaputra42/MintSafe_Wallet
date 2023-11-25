import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import 'evm_new_controller.dart';

class AddTokenController extends GetxController {
  EvmNewController evm = Get.find();
  var selectedTab = 0.obs;
  var isLoading = false.obs;
  var disableImportButton = true.obs;
  var isValidAddress = false.obs;
  final nameController = TextEditingController();
  final tokenAddressController = TextEditingController();
  final tokenSymbolController = TextEditingController();
  final decimalController = TextEditingController();

  void changeTab(int index) => selectedTab.value = index;

  onChangeName(String value) {
    checkButtonImport();
  }

  onChangeTokenAddress(String value) {
    isValidAddress.value = isValidEthereumAddress(value);
    checkButtonImport();
  }

  onChangeTokenSymbol(String value) {
    checkButtonImport();
  }

  onChangeDecimal(String value) {
    checkButtonImport();
  }

  void checkButtonImport() {
    if (nameController.text != '' &&
        tokenAddressController.text != '' &&
        tokenSymbolController.text != '' &&
        decimalController.text != '' &&
        isValidAddress.value == true) {
      disableImportButton.value = false;
    } else {
      disableImportButton.value = true;
    }
  }

  void setToken(SelectedToken token) async {
    if (evm.tokenSelected.any((element) =>
        element.contractAddress!.toLowerCase() ==
            token.contractAddress!.toLowerCase() &&
        element.walletAddress == evm.selectedAddress.value.address)) {
      await DbHelper.instance.deleteSelectedToken(token.contractAddress ?? "");
      await evm.initialzedToken();
      evm.tokenList.refresh();
      evm.tokenSelected.refresh();
    } else {
      await DbHelper.instance.setSelectedToken(token);
      await evm.initialzedToken();
      evm.tokenList.refresh();
      evm.tokenSelected.refresh();
    }
  }

  void setCustomToken() async {
    isLoading.value = true;
    SelectedToken selectedToken = SelectedToken(
        name: nameController.text,
        chainId: evm.selectedChain.value.chainId,
        contractAddress: tokenAddressController.text,
        symbol: tokenSymbolController.text,
        walletAddress: evm.selectedAddress.value.address,
        decimal: int.parse(decimalController.text),
        balance: 0,
        logo: 'asset/logo/logo_default.png');
    Token token = Token(
        name: nameController.text,
        contractAddress: tokenAddressController.text,
        symbol: tokenSymbolController.text,
        decimal: int.parse(decimalController.text),
        chainId: evm.selectedChain.value.chainId,
        balance: 0,
        logo: 'asset/logo/logo_default.png');
    if (evm.tokenSelected.any((element) =>
        element.contractAddress!.toLowerCase() ==
            selectedToken.contractAddress!.toLowerCase() &&
        element.walletAddress == evm.selectedAddress.value.address)) {
      await DbHelper.instance
          .deleteSelectedToken(selectedToken.contractAddress ?? "");
      await evm.initialzedToken();
      evm.tokenList.refresh();
      evm.tokenSelected.refresh();
    } else {
      await DbHelper.instance.setSelectedToken(selectedToken);
      await DbHelper.instance.setToken(token);
      await evm.initialzedToken();
      evm.tokenList.refresh();
      evm.tokenSelected.refresh();
    }
    Get.back();

    isLoading.value = false;
  }
}
