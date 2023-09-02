import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';

import '../../../data/data.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    //  ref.read(isNewUseProvider.notifier).checkFirstInstall();
    Timer(const Duration(seconds: 5), () {
       Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const GetStartedPage()),
            (route) => false);
      // if (ref.read(isNewUseProvider) == false) {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      //       (route) => false);
      // } else {
      //   if (ref.read(isLoginProvider) == true) {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => const MainScreen()),
      //         (route) => false);
      //   } else {
      //     Navigator.pushAndRemoveUntil(
      //         context,
      //         MaterialPageRoute(builder: (context) => LoginScreen()),
      //         (route) => false);
      //   }
      // }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgDark,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImage.maskSplash), fit: BoxFit.cover)),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.logo,
              width: 180.w,
            ),
            16.0.height,
            Text('MintSafe',
                style: AppFont.semibold24.copyWith(color: AppColor.textDark))
          ],
        )),
      ),
    );
  }
}
