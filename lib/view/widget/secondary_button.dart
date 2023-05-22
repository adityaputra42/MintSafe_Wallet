import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    this.height = 52,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    required this.onPressed,
  });

  final String title;
  final double width;
  final EdgeInsets margin;
  final double height;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height.h,
      margin: margin,
      decoration: BoxDecoration(
          gradient: AppGradient.secondaryButton,
          borderRadius: BorderRadius.circular(16.r)),
      child: TextButton(
        style: TextButton.styleFrom(
          
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r))),
        onPressed: onPressed,
        child: Text(
          title,
          style: AppFont.semibold16.copyWith(color: AppColor.primaryColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
