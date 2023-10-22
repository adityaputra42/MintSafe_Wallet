import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../widget/widget.dart';

class AlertPassword extends StatelessWidget {
  AlertPassword({super.key, required this.title, this.subTitle});
  final String title;
  final String? subTitle;
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
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
      return Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.ilustrasi6,
              width: 120.w,
              fit: BoxFit.cover,
            ),
            24.0.height,
            Text(
              subTitle ?? '',
              style: AppFont.reguler14.copyWith(color: AppColor.textDark),
              textAlign: TextAlign.center,
            ),
            24.0.height,
            InputText(
              title: 'Password',
              hintText: "Enter your password",
              controller: evm.passwordCreateAccountController,
              obscureText: true,
              icon: Icon(
                Icons.visibility_outlined,
                size: 20.w,
              ),
            ),
            24.0.height,
            PrimaryButton(
              loading: evm.isLoadingCreateAccount.value,
              title: "Confirm",
              onPressed: () {
                evm.createNewAddress();
              },
            )
          ],
        );
      });
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
