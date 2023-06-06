import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/src/app_icon.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';

class CardAction extends StatelessWidget {
  const CardAction({
    super.key,
    this.scan,
    this.receive,
    this.transfer,
    this.buy,
  });
  final Function()? scan;
  final Function()? receive;
  final Function()? transfer;
  final Function()? buy;
  @override
  Widget build(BuildContext context) {
    Widget cardAction(
        {Function()? ontap, required String title, required String image}) {
      return GestureDetector(
        onTap: ontap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.h,
              height: 48.h,
              padding: EdgeInsets.all(6.h),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.7.h,
                        spreadRadius: 0.4.h,
                        color: Colors.black12)
                  ],
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColor.primaryColor),
              child: Image.asset(image),
            ),
            8.0.height,
            Text(
              title,
              style: AppFont.semibold14,
            )
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cardAction(ontap: scan, title: "Scan", image: AppIcon.scanIcon),
          cardAction(
              ontap: receive, title: "Receive", image: AppIcon.receiveIcon),
          cardAction(
              ontap: transfer, title: "Transfer", image: AppIcon.trasnferIcon),
          cardAction(ontap: buy, title: "Buy", image: AppIcon.buyIcon),
        ],
      ),
    );
  }
}
