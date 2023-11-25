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
        color: '0xff1AA9A4',
        isTestnet: false,
        logo: 'asset/logo/logo_default.png');
    ChainNetwork chain = ChainNetwork(
        name: networkNameController.text,
        chainId: chainIdController.text,
        symbol: currencySymbolController.text,
        rpc: rpcUrlController.text,
        explorer: blockExplorerController.text,
        explorerApi: blockExplorerController.text,
        color: '0xff1AA9A4',
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
}
