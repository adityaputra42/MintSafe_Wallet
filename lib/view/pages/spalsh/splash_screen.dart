import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';

import '../../../data/data.dart';
import '../../../domain/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImage.maskSplash), fit: BoxFit.cover)),
        child: Center(
            child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.logo,
              width: 130.w,
            ),
            16.0.height,
            Text(
              'MintSafe',
              style: AppFont.semibold24.copyWith(color: Theme.of(context).indicatorColor)
            )
          ],
        )),
      ),
    );
  }
}