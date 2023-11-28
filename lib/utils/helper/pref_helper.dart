import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  late final SharedPreferences _pref;

  static PrefHelper instance = PrefHelper();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<bool> setFirstInstall() async {
    return await _pref.setBool("firstInstall", false);
  }

  bool get isFirstInstall => _pref.getBool("firstInstall") ?? true;
  Future<bool> setLogin(bool isLogin) async {
    return await _pref.setBool("isLogin", isLogin);
  }

  bool get isLogin => _pref.getBool("isLogin") ?? false;
}
