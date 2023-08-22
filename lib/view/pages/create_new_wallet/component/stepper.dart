import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../config/config.dart';
import '../create_new_wallet_page.dart';

class StepperCustom extends ConsumerWidget {
  const StepperCustom({super.key, });
 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var index = ref.watch(stepProvider);
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: (index == 0) ? 36.w : 28.w,
            height: (index == 0) ? 36.w : 28.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (index >= 0)
                    ? AppColor.primaryColor
                    : AppColor.grayColor),
            child: Center(
              child: index > 0
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.textDark,
                    )
                  : Text(
                      "1",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.textDark,
                          fontSize: (index == 0)
                              ? 16.sp
                              : 14.sp),
                    ),
            ),
          ),
          Container(
            width: 100.w,
            height: 2.w,
            color: (index >= 1)
                ? AppColor.primaryColor
                : AppColor.grayColor,
          ),
          Container(
            width: (index == 1) ? 36.w : 28.w,
            height: (index == 1) ? 36.w : 28.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (index >= 1)
                    ? AppColor.primaryColor
                    : AppColor.grayColor),
            child: Center(
              child: index > 1
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.textDark,
                    )
                  : Text(
                      "2",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.textDark,
                          fontSize: (index == 1)
                              ? 16.sp
                              : 14.sp),
                    ),
            ),
          ),
          Container(
            width: 100.w,
            height: 2.w,
            color: (index >= 2)
                ? AppColor.primaryColor
                : AppColor.grayColor,
          ),
          Container(
            width: (index == 2) ? 36.w : 28.w,
            height: (index == 2) ? 36.w : 28.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (index >= 2)
                    ? AppColor.primaryColor
                    : AppColor.grayColor),
            child: Center(
              child: index > 2
                  ? Icon(
                      Icons.check,
                      size: 20.h,
                      color: AppColor.textDark,
                    )
                  : Text(
                      "3",
                      style: AppFont.medium14.copyWith(
                          color: AppColor.textDark,
                          fontSize: (index == 2)
                              ? 16.sp
                              : 14.sp),
                    ),
            ),
          ),
         
        ],
      );
    });
  }
}
