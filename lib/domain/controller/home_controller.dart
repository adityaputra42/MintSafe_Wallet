import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  List<LinearGradient> cardList = [
    AppGradient.cardETH,
    AppGradient.cardBNB,
    AppGradient.cardARB,
    AppGradient.cardZK,
    AppGradient.cardMatic,
    AppGradient.card
  ];

  void onChangeTabIndex(int index) => tabIndex.value = index;
}
