import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/pages/add_wallet/add_wallet.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class ChangeWallet extends StatelessWidget {
  const ChangeWallet({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardAccount({required Color color, bool active = false}) {
      return Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            padding: EdgeInsets.all(2.h),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2.h, color: color)),
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: Image.asset(
                AppImage.avatar,
              ),
            ),
          ),
          8.0.width,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Wallet Saya",
                style: AppFont.medium14.copyWith(color: AppColor.textDark),
              ),
              8.0.height,
              Text(
                "0xf378gGkd9GKt39798djRJKJHSKiydku730g",
                style: AppFont.reguler12.copyWith(color: AppColor.textDark),
              )
            ],
          )),
          8.0.height,
          active
              ? Icon(
                  Icons.check_circle_outline_rounded,
                  size: 24.w,
                  color: AppColor.primaryColor,
                )
              : 24.0.width
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Change Wallet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            16.0.height,
            cardAccount(
              color: AppColor.primaryColor,
              active: true,
            ),
            12.0.height,
            cardAccount(
              color: AppColor.yellowColor,
            ),
            12.0.height,
            cardAccount(
              color: AppColor.grayColor,
            ),
            12.0.height,
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "want a new address?\nTap the below button to add.",
            style: AppFont.reguler12.copyWith(
              color: AppColor.grayColor,
            ),
            textAlign: TextAlign.center,
          ),
          SecondaryButton(
            title: "Add Network",
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 24.h,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              Get.to(()=>const AddWallet());
            },
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          ),
        ],
      ),
    );
  }
}
