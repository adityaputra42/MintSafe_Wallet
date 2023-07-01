// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:nusa_wallet/data/model/dapps_history.dart';
// import 'package:nusa_wallet/domain/controller/add_netwok_controller.dart';
// import 'package:nusa_wallet/domain/controller/evm_controller.dart';
// import 'package:web3_provider/web3_provider.dart';
// import 'package:web3dart/web3dart.dart';

// class DappsController extends GetxController {
//   EvmController evm = Get.find();
//   AddNetworkController addNetworkController = Get.put(AddNetworkController());
//   var title = "".obs;
//   var url = "".obs;
//   Web3Client? web3client;

//   late InAppWebViewController webController;

//   @override
//   void onInit() {
//     var httpClient = Client();
//     web3client = Web3Client(
//       evm.selectedChain.value.rpc ?? "",
//       httpClient,
//     );

//     super.onInit();
//   }

//   changedTitle(String value) {
//     title.value = value;
//   }

//   initWebController(InAppWebViewController controller) async {
//     webController = controller;
//     final title = await webController.getTitle();
//     final uri = await webController.getUrl();
//     final image = await webController.requestImageRef();

//     url.value = uri.toString();

//     if (title != "") {
//       await evm.addDappsHistory(DappsHistory(
//           title: title, url: uri.toString(), image: image!.url.toString()));
//     }
//   }
// }