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
        child: Container(
          width: MediaQuery.of(context).size.width*0.24,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 1.h,
                    spreadRadius:1.h,
                    color: AppColor.primaryColor.withOpacity(0.2))
              ],
              borderRadius: BorderRadius.circular(8.r),
              color: AppColor.secondaryColor),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, width: 20.w,height: 20.h,) ,8.0.width,Text(
          title,
          style: AppFont.medium14 .copyWith(color: Colors.white),
        )
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cardAction(ontap: scan, title: "Scan", image: AppIcon.scanIcon),
          cardAction(
              ontap: receive, title: "Receive", image: AppIcon.receiveIcon),
          cardAction(
              ontap: transfer, title: "Transfer", image: AppIcon.trasnferIcon),
          
        ],
      ),
    );
  }
}
