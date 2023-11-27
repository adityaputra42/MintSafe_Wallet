import 'dart:async';
import 'dart:io';

import 'package:ffcache/ffcache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mintsafe_wallet/config/theme/style.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';
import 'package:mintsafe_wallet/view/pages/spalsh/splash_screen.dart';

import 'domain/controller/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
 
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

  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  /// Make this stream available throughout the widget tree with with any state management library
  /// like bloc, provider, GetX, ..
  final sessionStateStream = StreamController<SessionState>();

  @override
  Widget build(BuildContext context) {
    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(seconds: 5),
      invalidateSessionForUserInactivity: const Duration(seconds: 4),
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      sessionStateStream.add(SessionState.stopListening);
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        // handle user  inactive timeout
       
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
       
      }
    });
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Obx(() {
            return SessionTimeoutManager(
              userActivityDebounceDuration: const Duration(seconds: 1),
              sessionConfig: sessionConfig,
              sessionStateStream: sessionStateStream.stream,
              child: GetMaterialApp(
                  title: 'MintSafe Wallet',
                  debugShowCheckedModeBanner: false,
                  theme: Styles.themeData(
                      themeController.darkTheme.value, context),
                  home: SplashScreen()),
            );
          });
        });
  }
}
