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
            width: (controller.stepIndex.value == 0) ? 40.w : 32.w,
            height: (controller.stepIndex.value == 0) ? 40.w : 32.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (controller.stepIndex.value >= 0)
                    ? AppColor.primaryColor
                    : AppColor.darkerGray),
            child: Center(
              child: controller.stepIndex.value > 0
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.white,
                    )
                  : Text(
                      "1",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.white,
                          fontSize: (controller.stepIndex.value == 0)
                              ? 20.sp
                              : 14.sp),
                    ),
            ),
          ),
          Container(
            width: 80.w,
            height: 3.w,
            color: (controller.stepIndex.value >= 1)
                ? AppColor.primaryColor
                : AppColor.darkerGray,
          ),
          Container(
            width: (controller.stepIndex.value == 1) ? 40.w : 32.w,
            height: (controller.stepIndex.value == 1) ? 40.w : 32.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (controller.stepIndex.value >= 1)
                    ? AppColor.primaryColor
                    : AppColor.darkerGray),
            child: Center(
              child: controller.stepIndex.value > 1
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.white,
                    )
                  : Text(
                      "2",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.white,
                          fontSize: (controller.stepIndex.value == 1)
                              ? 20.sp
                              : 14.sp),
                    ),
            ),
          ),
          Container(
            width: 80.w,
            height: 3.w,
            color: (controller.stepIndex.value >= 2)
                ? AppColor.primaryColor
                : AppColor.darkerGray,
          ),
          Container(
            width: (controller.stepIndex.value == 2) ? 40.w : 32.w,
            height: (controller.stepIndex.value == 2) ? 40.w : 32.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (controller.stepIndex.value >= 2)
                    ? AppColor.primaryColor
                    : AppColor.darkerGray),
            child: Center(
              child: controller.stepIndex.value > 2
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.white,
                    )
                  : Text(
                      "3",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.white,
                          fontSize: (controller.stepIndex.value == 2)
                              ? 20.sp
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
