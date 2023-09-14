import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';

class SuccesCreateWallet extends StatelessWidget {
  const SuccesCreateWallet({super.key, required this.address});
  final Address address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgDark,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.ilustrasi4,
              width: 334.w,
            ),
            24.0.height,
            Text(
              "Yeay 🎉",
              style: AppFont.semibold24.copyWith(color: AppColor.textDark),
            ),
            8.0.height,
            Text(
              'successfully created a new wallet',
              style: AppFont.reguler16.copyWith(color: AppColor.grayColor),
            ),
            PrimaryButton(
              title: "Start Now",
              onPressed: () {
                Get.offAll(() => MainPage(
                      address: address,
                    ));
              },
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 48.h),
            )
          ],
        ),
      ),
    );
  }
}
