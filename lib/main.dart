import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/helper/database_helper.dart';
import 'package:mintsafe_wallet/config/theme/style.dart';
import 'package:mintsafe_wallet/utils/helper/pref_helper.dart';
import 'package:mintsafe_wallet/view/pages/spalsh/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefHelper.instance.init();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  DatabaseHelper.instance.onInit();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'MintSafe Wallet',
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(true, context),
              home: SplashScreen());
        });
  }
}
