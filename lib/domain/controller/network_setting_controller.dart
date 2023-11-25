import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

class NetworkSettingController extends GetxController {
  final ChainNetwork network;

  NetworkSettingController({required this.network});
  final rpcEnable = false.obs;
  final isLoading = false.obs;
  final nameController = TextEditingController();
  final rpcController = TextEditingController();
  final symbolController = TextEditingController();
  final chainIdController = TextEditingController();
  final explorerController = TextEditingController();
  var rpcFocus = FocusNode().obs;
  final EvmNewController evm = Get.find();

  changeEnable(bool value) {
    rpcEnable.value = value;
  }

  void updateRpc() async {
    isLoading.value = true;
    await DbHelper.instance
        .updateRPC(chainId: network.chainId!, rpc: rpcController.text);
    await evm.initialzedNetwork();
    evm.listChain.refresh();
    evm.listChainSelected.refresh();
    Get.snackbar("Success", "RPC ${network.name} has been updated",
        colorText: AppColor.textDark, backgroundColor: AppColor.primaryColor);
    rpcEnable.value = false;
    isLoading.value = false;
  }

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
