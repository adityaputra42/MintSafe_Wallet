import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../widget/widget.dart';

class AlertPassword extends StatelessWidget {
  const AlertPassword({super.key, required this.title, this.subTitle});
  final String title;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: 900.w,
        height: 60.h,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppFont.medium16
                      .copyWith(color: AppColor.textDark, fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  color: AppColor.textDark,
                  size: 24.w,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImage.ilustrasi6,
            width: 240.w,
          ),
          24.0.height,
          Text(
            subTitle ?? '',
            style: AppFont.reguler14.copyWith(color: AppColor.textDark),
            textAlign: TextAlign.center,
          ),
          24.0.height,
          const InputText(title: 'Password', hintText: "Enter your password"),
          24.0.height,
          PrimaryButton(
            title: "Confirm",
            onPressed: () {},
          )
        ],
      );
    }

    return AlertDialog(
      backgroundColor: AppColor.bgDark,
      titlePadding: EdgeInsets.zero,
      title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
