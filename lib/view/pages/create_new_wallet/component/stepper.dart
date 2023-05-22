import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';

class StepperCustom extends StatelessWidget {
  const StepperCustom({super.key, required this.currentStep});
  final int currentStep;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: (currentStep == 0) ? 50.w : 40.w,
          height: (currentStep == 0) ? 50.w : 40.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (currentStep >= 0)
                  ? AppColor.primaryColor
                  : AppColor.softGreen),
          child: Center(
            child: currentStep > 0
                ? Icon(
                    Icons.check,
                    size: 20.h,
                    color: AppColor.white,
                  )
                : Text(
                    "1",
                    style: AppFont.semibold14.copyWith(
                        color: AppColor.white,
                        fontSize: (currentStep == 0) ? 16.sp : 12.sp),
                  ),
          ),
        ),
        Container(
          width: 80.w,
          height: 3.w,
          color:
              (currentStep >= 1) ? AppColor.primaryColor : AppColor.softGreen,
        ),
        Container(
          width: (currentStep == 1) ? 50.w : 40.w,
          height: (currentStep == 1) ? 50.w : 40.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (currentStep >= 1)
                  ? AppColor.primaryColor
                  : AppColor.softGreen),
          child: Center(
            child:currentStep > 1
                ? Icon(
                    Icons.check,
                    size: 20.h,
                    color: AppColor.white,
                  )
                : Text(
              "2",
              style: AppFont.semibold14.copyWith(
                  color: AppColor.white,
                  fontSize: (currentStep == 0) ? 18.sp : 12.sp),
            ),
          ),
        ),
        Container(
          width: 80.w,
          height: 3.w,
          color:
              (currentStep >= 2) ? AppColor.primaryColor : AppColor.softGreen,
        ),
        Container(
          width: (currentStep == 2) ? 50.w : 40.w,
          height: (currentStep == 2) ? 50.w : 40.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (currentStep >= 2)
                  ? AppColor.primaryColor
                  : AppColor.softGreen),
          child: Center(
            child:currentStep > 2
                ? Icon(
                    Icons.check,
                    size: 20.h,
                    color: AppColor.white,
                  )
                : Text(
              "3",
              style: AppFont.semibold14.copyWith(
                  color: AppColor.white,
                  fontSize: (currentStep == 2) ? 18.sp : 12.sp),
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
  }
}
