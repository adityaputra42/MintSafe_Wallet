import 'dart:developer';

import 'package:get/get.dart';

import '../../data/data.dart';
import '../repository/repository.dart';
import 'evm_new_controller.dart';

class ActivityTxController extends GetxController {
  var isLoading = false.obs;
  var listActivity = <Activity>[].obs;
  var selectedTabActivity = 0.obs;
  var page = 1.obs;

  final EvmNewController evm = Get.find();

  @override
  void onInit() {
    findAllActivity();
    super.onInit();
  }

  void changeActivity(int index) => selectedTabActivity.value = index;

  Future<void> findAllActivity({bool isRefresh = false}) async {
    isLoading.value = true;
    ActivityRepository activityRepository = ActivityRepository();

    final response = await activityRepository.findAllActivity(
        page: isRefresh ? 1 : page.value,
        evm.selectedAddress.value.address ?? "",
        isTestnet: evm.selectedChain.value.isTestnet ?? false);

    final tokenResponse = await activityRepository.findActivityToken(
        evm.selectedAddress.value.address ?? "",
        page: page.value,
        isTestnet: evm.selectedChain.value.isTestnet!);

    for (var element in tokenResponse) {
      log("Token name  : ${element.name}");
    }

    for (int i = 0; i < response.length; i++) {
      if (response[i].contractAddress == "") {
        var token = tokenResponse.singleWhere(
          (element) => element.hash == response[i].hash,
          orElse: () {
            return response[i];
          },
        );

        response[i] = response[i].copyWith(
            name: token.name,
            symbol: token.symbol,
            decimal: token.decimal,
            value: token.value,
            contractAddress: token.contractAddress);
      }

      // print(response[i].name);
      // print(response[i].value);
      // print(response[i].symbol);
      // print(response[i].input);
    }
    if (isRefresh) {
      page.value = 1;
      listActivity.clear();
    }

    listActivity.assignAll(response);

    // for (Activity activity in listActivity) {
    //   if (activity.input != "0x" && activity.input != "") {
    //     var data = hex.decode(activity.input!.substring(2));
    //     try {
    //       var call = abi.decomposeCall(Uint8List.fromList(data));
    //       print(call.functionName);
    //       activity.method = call.functionName.substring(0, 1).toUpperCase() +
    //           call.functionName.substring(1);
    //       ;
    //       activity.value = call.getCallParam('_value').toString();
    //     } catch (e) {
    //       activity.method = "Smart Contract Call";
    //       activity.name = selectedChain.value.symbol;
    //       print(e.toString());
    //     }
    //   }
    // }

    // listActivity.forEach((element) async {
    //   if (element.contractAddress != "") {
    //     final token = ERC20(
    //         client: web3client!,
    //         address: EthereumAddress.fromHex(element.contractAddress!));

    //     // element. = await token.name();
    //     // element.symbol = await token.symbol();

    //     // var data = hex.decode(element.input!);
    //     // print(data);
    //     // var call = contractABI.decomposeCall(Uint8List.fromList(data));

    //     // print(call.callParams);
    //   }
    // });

    listActivity.refresh();
    isLoading.value = false;
  }
}
