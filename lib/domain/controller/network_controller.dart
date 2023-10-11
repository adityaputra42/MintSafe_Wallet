import 'dart:developer' as dev;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/chain_network/selected_chain.dart';

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
    List<int> id = [];
    for (final value in networkList) {
      id.add(value.id!);
    }
    await DbHelper.instance.deleteAllChainNetwork(id);
    final chainlist = await rootBundle.loadString('asset/abi/chain.json');
    listChain.value = chainNetworkFromJson(chainlist);
    await DbHelper.instance.setChainNetwork(listChain);
   final chainSelected= await DbHelper.instance.getSelectedChain();
    if (chainSelected.chainId == null) {
      final selected = SelectedChain(chainId: listChain.first.chainId);
      await DbHelper.instance.setSelectedChain(selected);
      selectedChain.value = listChain.first;
    } else {
      var chain = await DbHelper.instance.getSelectedChainNetwork();
      selectedChain.value = chain!;
    }
    selectedChain.refresh();
    listChain.refresh();
    dev.log("Selected chain ==> ${selectedChain.value.chainId}");
    for (var value in listChain) {
      dev.log("List Chain ==> ${value.chainId}");
    }
  }


    void changeNetwork(ChainNetwork network) async {
    // var httpClient = Client();
    // Get.back();

   
    selectedChain.value = network;
    selectedChain.refresh();

    // isLoadingNetwork.value = true;

    await DbHelper.instance.changeNetwork(network);

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
