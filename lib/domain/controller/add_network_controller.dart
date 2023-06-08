import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNetworkController extends GetxController {
  var selectedTab = 0.obs;
  final networkNameController = TextEditingController();
  final rpcUrlController = TextEditingController();
  final chainIdController = TextEditingController();
  final currencySymbolController = TextEditingController();
  final blockExplorerController = TextEditingController();

  void changeTab(int index) => selectedTab.value = index;
}
