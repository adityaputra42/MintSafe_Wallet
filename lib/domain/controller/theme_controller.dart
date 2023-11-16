import 'package:get/get.dart';

import '../../utils/helper/dark_theme.dart';

class ThemeController extends GetxController {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  RxBool darkTheme = false.obs;

  @override
  void onInit() {
    getTheme();
    super.onInit();
  }

  getTheme() async {
    darkTheme.value = await darkThemePreference.getTheme();
  }

  void setDarkTheme(bool value) {
    darkTheme.value = value;
    darkThemePreference.setDarkTheme(value);
  }
}
