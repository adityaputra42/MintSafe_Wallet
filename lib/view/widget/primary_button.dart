import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../config/config.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.height = 54,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    required this.onPressed,
    this.disable = false,
    this.icon,
    this.loading = false,
  });

  final String title;
  final double width;
  final EdgeInsets margin;
  final double height;
  final Function() onPressed;
  final bool disable;
  final bool loading;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
                disable ? AppColor.secondaryColor : AppColor.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r))),
        onPressed: disable || loading ? () {} : onPressed,
        child: loading
            ? Padding(
                padding: EdgeInsets.all(8.h),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.softGreen,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? const SizedBox(),
                  icon != null ? 8.0.width : 0.0.width,
                  Text(
                    title,
                    style: AppFont.semibold16.copyWith(color: AppColor.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
