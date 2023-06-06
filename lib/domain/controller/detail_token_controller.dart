import 'package:get/get.dart';

class DetailTokenController extends GetxController {
  var tabIndex = 0.obs;
  void onChangeTabIndex(int index) => tabIndex.value = index;
}
