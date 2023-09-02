import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mintsafe_wallet/domain/controller/create_wallet_controller.dart';

import '../../../../config/config.dart';

class StepperCustom extends StatelessWidget {
  const StepperCustom({super.key, required this.controller});
  final CreateWalletController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: (controller.stepIndex.value == 0) ? 36.w : 28.w,
            height: (controller.stepIndex.value == 0) ? 36.w : 28.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (controller.stepIndex.value >= 0)
                    ? AppColor.primaryColor
                    : AppColor.grayColor),
            child: Center(
              child: controller.stepIndex.value > 0
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.textDark,
                    )
                  : Text(
                      "1",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.textDark,
                          fontSize: (controller.stepIndex.value == 0)
                              ? 16.sp
                              : 14.sp),
                    ),
            ),
          ),
          Container(
            width: 100.w,
            height: 2.w,
            color: (controller.stepIndex.value >= 1)
                ? AppColor.primaryColor
                : AppColor.grayColor,
          ),
          Container(
            width: (controller.stepIndex.value == 1) ? 36.w : 28.w,
            height: (controller.stepIndex.value == 1) ? 36.w : 28.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (controller.stepIndex.value >= 1)
                    ? AppColor.primaryColor
                    : AppColor.grayColor),
            child: Center(
              child: controller.stepIndex.value > 1
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.textDark,
                    )
                  : Text(
                      "2",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.textDark,
                          fontSize: (controller.stepIndex.value == 1)
                              ? 16.sp
                              : 14.sp),
                    ),
            ),
          ),
          Container(
            width: 100.w,
            height: 2.w,
            color: (controller.stepIndex.value >= 2)
                ? AppColor.primaryColor
                : AppColor.grayColor,
          ),
          Container(
            width: (controller.stepIndex.value == 2) ? 36.w : 28.w,
            height: (controller.stepIndex.value == 2) ? 36.w : 28.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (controller.stepIndex.value >= 2)
                    ? AppColor.primaryColor
                    : AppColor.grayColor),
            child: Center(
              child: controller.stepIndex.value > 2
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.textDark,
                    )
                  : Text(
                      "3",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.textDark,
                          fontSize: (controller.stepIndex.value == 2)
                              ? 16.sp
                              : 14.sp),
                    ),
            ),
          ),
          // Container(
          //   width: 30.w,
          //   height: 3.w,
          //   color:
          //       (currentStep >= 3) ? AppColor.primaryColor : AppColor.softGreen,
          // ),
        ],
      );
    });
  }
}