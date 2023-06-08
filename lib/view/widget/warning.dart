import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../config/config.dart';

class Warning extends StatelessWidget {
  const Warning({super.key, required this.warning});
  final String warning;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: AppGradient.warning),
      child: Row(
        children: [
          Icon(
            Icons.warning_rounded,
            size: 32.h,
            color: const Color(0xffF7931A),
          ),
          12.0.width,
          Expanded(
            child: Text(
              warning,
              style: AppFont.reguler14,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
