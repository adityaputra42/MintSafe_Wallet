import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import 'evm_new_controller.dart';

class ChangeNetworkController extends GetxController {
  EvmNewController evm = Get.find();
  var listChain = <ChainNetwork>[].obs;

  @override
  void onInit() {
    listChain = evm.networkController.listChain;
    super.onInit();
  }

  void changeNetwork(ChainNetwork network, BuildContext context) async {
    var httpClient = http.Client();
    Get.back();
    evm.networkController.selectedChain.value = network;
    evm.networkController.selectedChain.refresh();
    evm.isLoadingNetwork.value = true;
    await DbHelper.instance.changeNetwork(network);
    evm.web3client = Web3Client(
      evm.networkController.selectedChain.value.rpc ?? "",
      httpClient,
    );
    evm.tokenSelected.clear();
    final tokens = await DbHelper.instance.getSelectedToken(
      walletAddress: evm.selectedAddress.value.address ?? "",
      chainID: network.chainId ?? "",
    );
    evm.tokenSelected.value = tokens;
    final tokenByChain = await DbHelper.instance
        .getListTokenByChainId(chainId: network.chainId ?? "");
    evm.tokenList.value = tokenByChain;
    evm.isLoadingNetwork.value = false;
    // await getMultipleTokenBalances();
    Get.back();
  }
}
