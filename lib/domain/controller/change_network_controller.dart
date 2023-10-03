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
    listChain = evm.listChain;
    super.onInit();
  }

  void changeNetwork(ChainNetwork network, BuildContext context) async {
    var httpClient = http.Client();
    Get.back();
    await DbHelper.instance.unSelectNetwork(evm.selectedChain.value.id!);
    evm.selectedChain.value = network;
    evm.selectedChain.refresh();
    evm.isLoadingNetwork.value = true;
    await DbHelper.instance.changeNetwork(network.id!);
    evm.web3client = Web3Client(
      evm.selectedChain.value.rpc ?? "",
      httpClient,
    );
    // await getBalance();
    // // await findAllActivity();
    evm.isLoadingNetwork.value = false;
    // await getMultipleTokenBalances();
    Get.back();
  }
}
