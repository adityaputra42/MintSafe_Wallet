import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/helper/pref_helper.dart';

class IsNewUserNootifier extends StateNotifier<bool> {
  IsNewUserNootifier() : super(false);
  void checkFirstInstall() {
    state = PrefHelper.instance.isFirstInstall;
  }
}

final isNewUseProvider = StateNotifierProvider<IsNewUserNootifier, bool>(
    (ref) => IsNewUserNootifier());

final isLoginProvider = StateProvider<bool>((ref) => false);
