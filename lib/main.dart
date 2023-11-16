import 'package:ffcache/ffcache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/theme/style.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';
import 'package:mintsafe_wallet/view/pages/spalsh/splash_screen.dart';

import 'domain/controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dotenv.load(fileName: ".env");
  await FFCache(
    name: 'activity',
  ).init();
  DbHelper.instance.onInit();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    await themeController.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Obx(() {
            return GetMaterialApp(
                title: 'MintSafe Wallet',
                debugShowCheckedModeBanner: false,
                theme:
                    Styles.themeData(themeController.darkTheme.value, context),
                home: SplashScreen());
          });
        });
  }
}
