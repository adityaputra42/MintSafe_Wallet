import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';

class Empty extends StatelessWidget {
  const Empty({super.key, required this.title, this.width = 160});
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.empty,
              width: width.w,
            ),
            0.0.height,
            Text(
              title,
              style: AppFont.medium14
                  .copyWith(color: Theme.of(context).indicatorColor),
            )
          ],
        ),
      ),
    );
  }
}
