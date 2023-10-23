import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import 'alert_detail_activity.dart';

class CardActivity extends StatelessWidget {
  const CardActivity({
    this.title,
    super.key,
  });
  final String? title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(const AlertDetailActivity());
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 0.3, spreadRadius: 0.5, color: Colors.black12)
        ], borderRadius: BorderRadius.circular(8.r), color: AppColor.cardDark),
        child: Row(
          children: [
            Image.asset(
              AppIcon.receiveActivity,
              color: AppColor.textDark,
              width: 36.w,
            ),
            8.0.width,
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          title ?? "Smart Contract Call",
                          style: AppFont.medium16
                              .copyWith(color: AppColor.textDark),
                        ),
                        4.0.width,
                        Text(
                          "(ETH)",
                          style: AppFont.medium14
                              .copyWith(color: AppColor.grayColor),
                        ),
                      ],
                    ),
                    Text(
                      "0.00 ETH",
                      style:
                          AppFont.medium16.copyWith(color: AppColor.textDark),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Confirmed",
                      style: AppFont.medium14
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    Text(
                      DateFormat("MMM dd, yyyy").format(DateTime.now()),
                      style:
                          AppFont.reguler14.copyWith(color: AppColor.grayColor),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
