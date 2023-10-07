import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import 'evm_new_controller.dart';
import 'network_controller.dart';

class ChangeNetworkController extends GetxController {
  NetworkController networkController = Get.find();
  EvmNewController evm =Get.find();
  var listChain = <ChainNetwork>[].obs;

  @override
  void onInit() {
    listChain = networkController.listChain;
    super.onInit();
  }

  void changeNetwork(ChainNetwork network, BuildContext context) async {
    var httpClient = http.Client();
    Get.back();
    await DbHelper.instance.unSelectNetwork(networkController.selectedChain.value.id!);
    networkController.selectedChain.value = network;
    networkController.selectedChain.refresh();
    // networkController.isLoadingNetwork.value = true;
    await DbHelper.instance.changeNetwork(network.id!);
    evm.web3client = Web3Client(
      networkController.selectedChain.value.rpc ?? "",
      httpClient,
    );
   
    evm.isLoadingNetwork.value = false;
    // await getMultipleTokenBalances();
    Get.back();
  }
}
