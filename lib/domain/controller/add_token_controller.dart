import 'package:get/get.dart';

class AddTokenController extends GetxController {
  var selectedTab = 0.obs;

  void changeTab(int index) => selectedTab.value = index;
}
