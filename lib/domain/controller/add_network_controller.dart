import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/chain_network/list_chain_selected.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';

import '../../utils/utils.dart';

class AddNetworkController extends GetxController {
  var selectedTab = 0.obs;
  final networkNameController = TextEditingController();
  final rpcUrlController = TextEditingController();
  final chainIdController = TextEditingController();
  final currencySymbolController = TextEditingController();
  final blockExplorerController = TextEditingController();
  final EvmNewController evm = Get.find();

  void changeTab(int index) => selectedTab.value = index;

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

    Get.back();
  }
}
