import 'package:get/get.dart';

class BottomNavBarController extends GetxController {

  var indexBar = 0.obs;

  void changeIndexBar(int index)=> indexBar.value = index;
}