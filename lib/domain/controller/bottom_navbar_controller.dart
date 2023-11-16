import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'evm_new_controller.dart';

class BottomNavBarController extends GetxController {

  var indexBar = 0.obs;

   var selectedIndex = 0.obs;
  var isOpenAddress = false.obs;
  var isSearch = false.obs;
  var isLoadExplorer = false.obs;

  var isTabClicked = false.obs;

  void selectTab(bool value) => isTabClicked.value = value;

  void changeIndexBar(int index) {
    indexBar.value = index;
    isOpenAddress.value = false;
  }

  TextEditingController initialUrl = TextEditingController();

  String urlAddress(String address, EvmNewController evm) =>
      "${evm.selectedChain.value.explorer}/address/$address";

  String urlExplorer(EvmNewController evm) =>
      "${evm.selectedChain.value.explorer}";

  setSearch(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        isSearch.value = true;
      } else {
        isSearch.value = false;
      }
    }
  }

  clearSearch() {
    initialUrl.clear();
    isSearch.value = false;
  }

  void toExplorer() {
    isOpenAddress.value = true;
    selectedIndex.value = 2;
  }
}