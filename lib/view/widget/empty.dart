import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';

class Empty extends StatelessWidget {
  const Empty({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImage.empty,
            width: 120.w,
          ),
          16.0.height,
          Text(
            title,
            style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
          )
        ],
      ),
    );
  }
}
