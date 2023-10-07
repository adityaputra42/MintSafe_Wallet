import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';

class NetworkController extends GetxController {
  var selectedChain = ChainNetwork().obs;
  var listChain = <ChainNetwork>[].obs;

  /// DATABASE

 Future<void> initialzedNetwork() async {
    /// GET LIST NETWORK
    listChain.clear();
    final networkList = await DbHelper.instance.getAllChainNetwork();

    if (networkList.isEmpty) {
      print("NETWORK FROM JSON");
      final chainlist = await rootBundle.loadString('asset/abi/chain.json');

      listChain.value = chainNetworkFromJson(chainlist);
      listChain[0].selected = true;
      await DbHelper.instance.setChainNetwork(listChain);

      final selectedNetwork = await DbHelper.instance.getSelectedChainNetwork();
      if (selectedNetwork == null) {
        selectedChain.value = listChain[0];
      } else {
        selectedChain.value = selectedNetwork;
      }

      print("SET JSON TO DB");
    } else {
      print(" NETWORK FROM DB");
      var chain = await DbHelper.instance.getSelectedChainNetwork();
      selectedChain.value = chain!;
      listChain.value = networkList;
    }

    selectedChain.refresh();
    listChain.refresh();

    listChain.forEach((element) {
      log(element.name!);
    });
  }


    void changeNetwork(ChainNetwork network) async {
    // var httpClient = Client();
    // Get.back();

    await DbHelper.instance.unSelectNetwork(selectedChain.value.id!);
    selectedChain.value = network;
    selectedChain.refresh();

    // isLoadingNetwork.value = true;

    await DbHelper.instance.changeNetwork(network.id!);

    // web3client = Web3Client(
    //   selectedChain.value.rpc ?? "",
    //   httpClient,
    // );

    // await getBalance();
    // await findAllActivity();
    // isLoadingNetwork.value = false;
    // await getMultipleTokenBalances();
  }
}
