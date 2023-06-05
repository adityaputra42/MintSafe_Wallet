import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardWallet() {
      return Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: const LinearGradient(
                colors: [Color(0xff5631FA), Color(0xff627EEA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            image: const DecorationImage(
                image: AssetImage(AppImage.masking), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("~\$123.673",
                  style: AppFont.semibold24.copyWith(
                    color: AppColor.white,
                  )),
              8.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("0xfhas7gjkd....ashajk3q9c",
                      style: AppFont.medium14.copyWith(
                        color: AppColor.white,
                      )),
                  8.0.width,
                  Icon(
                    Icons.copy,
                    size: 18.h,
                    color: AppColor.greenBuy,
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            24.0.height,
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2.h, color: AppColor.primaryColor)),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor,
                    ),
                    child: Image.asset(
                      AppImage.avatar,
                    ),
                  ),
                ),
                8.0.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, Welcome Back",
                      style: AppFont.reguler12,
                    ),
                    Text(
                      "Dompet Saya",
                      style: AppFont.medium14,
                    )
                  ],
                )
              ],
            ),
            24.0.height,
            cardWallet()
          ],
        ),
      )),
    );
  }
}
