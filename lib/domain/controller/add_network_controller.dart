import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/data/model/chain_network/list_chain_selected.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';

import '../../utils/utils.dart';

class AddNetworkController extends GetxController {
  var selectedTab = 0.obs;
  var isLoading = false.obs;
  final networkNameController = TextEditingController();
  final rpcUrlController = TextEditingController();
  final chainIdController = TextEditingController();
  final currencySymbolController = TextEditingController();
  final blockExplorerController = TextEditingController();
  var isDisable = true.obs;
  final EvmNewController evm = Get.find();

  void changeTab(int index) => selectedTab.value = index;

  List<String> listColor = [
    "0xffFF6C22",
    "0xff00A9FF",
    "0xff190482",
    "0xff64CCC5",
    "0xffEBE76C",
    "0xff91C8E4",
    "0xffD71313",
    "0xff9BABB8",
    "0xff643843",
    "0xff088395",
    "0xffE5BEEC",
    "0xffC9A7EB",
    "0xffB0DAFF",
    "0xffD5B4B4",
    "0xff867070",
    "0xff7752FE",
    "0xffC2D9FF",
  ];
  String getRandomValue() {
    Random random = Random();
    int randomIndex = random.nextInt(listColor.length);
    return listColor[randomIndex];
  }

  validateButton() {
    if (networkNameController.text != '' &&
        rpcUrlController.text != '' &&
        chainIdController.text != '' &&
        currencySymbolController.text != '' &&
        blockExplorerController.text != '') {
      isDisable.value = false;
    } else {
      isDisable.value = true;
    }
  }

  void onChangeInputText(String value) {
    validateButton();
  }

  void setChain(ListChainSelected chain) async {
    if (evm.listChainSelected.any((element) =>
        element.chainId!.toLowerCase() == chain.chainId!.toLowerCase() &&
        element.walletAddress == evm.selectedAddress.value.address)) {
      await DbHelper.instance.deleteSelectedChainWallet(chain.chainId ?? "");
      await evm.initialzedNetwork();
      evm.tokenList.refresh();
      evm.listChainSelected.refresh();
    } else {
      await DbHelper.instance.setSelectedChainWallet(chain);
      await evm.initialzedNetwork();
      evm.listChain.refresh();
      evm.listChainSelected.refresh();
    }
  }

  void setCustomNetwork() async {
    isLoading.value = true;
    ListChainSelected selectedChain = ListChainSelected(
        name: networkNameController.text,
        chainId: chainIdController.text,
        symbol: currencySymbolController.text,
        walletAddress: evm.selectedAddress.value.address,
        rpc: rpcUrlController.text,
        explorer: blockExplorerController.text,
        explorerApi: blockExplorerController.text,
        color: getRandomValue(),
        isTestnet: false,
        logo: 'asset/logo/logo_default.png');
    ChainNetwork chain = ChainNetwork(
        name: networkNameController.text,
        chainId: chainIdController.text,
        symbol: currencySymbolController.text,
        rpc: rpcUrlController.text,
        explorer: blockExplorerController.text,
        explorerApi: blockExplorerController.text,
        color: getRandomValue(),
        isTestnet: false,
        logo: 'asset/logo/logo_default.png');
    if (evm.listChainSelected.any((element) =>
        element.chainId!.toLowerCase() ==
            selectedChain.chainId!.toLowerCase() &&
        element.walletAddress == evm.selectedAddress.value.address)) {
      await DbHelper.instance
          .deleteSelectedChainWallet(selectedChain.chainId ?? "");
      await evm.initialzedNetwork();
      evm.listChain.refresh();
      evm.listChainSelected.refresh();
    } else {
      await DbHelper.instance.setSelectedChainWallet(selectedChain);
      await DbHelper.instance.setChainNetwork(chain);
      await evm.initialzedNetwork();
      evm.listChain.refresh();
      evm.listChainSelected.refresh();
    }
    Get.back();

    isLoading.value = false;
  }

  void setChainNetwork(
      {required ListChainSelected chainSelected,
      required ChainNetwork chainNetwork}) async {
    isLoading.value = true;

    await DbHelper.instance.setSelectedChainWallet(chainSelected);
    await DbHelper.instance.setChainNetwork(chainNetwork);
    await evm.initialzedNetwork();
    evm.listChain.refresh();
    evm.listChainSelected.refresh();

    Get.back();

    isLoading.value = false;
  }
}
