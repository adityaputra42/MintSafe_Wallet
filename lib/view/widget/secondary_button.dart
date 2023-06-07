import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';

import '../../config/config.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    this.height = 52,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.icon,
    required this.onPressed,
  });

  final String title;
  final double width;
  final EdgeInsets margin;
  final double height;
  final Widget? icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      margin: margin,
      decoration: BoxDecoration(
          gradient: AppGradient.secondaryButton,
          boxShadow: [
            BoxShadow(
                blurRadius: 0.3.h, spreadRadius: 0.3.h, color: Colors.black12)
          ],
          borderRadius: BorderRadius.circular(16.r)),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r))),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            icon != null ? 8.0.width : 0.0.width,
            Text(
              title,
              style: AppFont.semibold16.copyWith(color: AppColor.primaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
