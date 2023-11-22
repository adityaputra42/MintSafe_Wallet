import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';

class NetworkSettingController extends GetxController {
  final ChainNetwork network;
  NetworkSettingController({required this.network});

  final nameController = TextEditingController();
  final rpcController = TextEditingController();
  final symbolController = TextEditingController();
  final chainIdController = TextEditingController();
  final explorerController = TextEditingController();

  @override
  void onInit() {
    nameController.text = network.name ?? "";
    rpcController.text = network.rpc ?? '';
    symbolController.text = network.symbol ?? '';
    chainIdController.text = network.chainId.toString();
    explorerController.text = network.explorer ?? '';
    super.onInit();
  }
}
