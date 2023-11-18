import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../domain/controller/evm_new_controller.dart';
import 'alert_detail_activity.dart';

class CardActivity extends StatelessWidget {
  CardActivity({
    required this.activity,
    super.key,
  });

  final EvmNewController evm = Get.find();
  final Activity activity;
  @override
  Widget build(BuildContext context) {
    String state = activity.from == evm.selectedAddress.value.address
        ? "Transfer"
        : "Receiced";
    return GestureDetector(
      onTap: () {
        Get.dialog(AlertDetailActivity(
          activity: activity,
          state: state,
        ));
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 0.3, spreadRadius: 0.5, color: Colors.black12)
        ], borderRadius: BorderRadius.circular(8.r), color: Theme.of(context).cardColor),
        child: Row(
          children: [
            Image.asset(
              state == "Transfer"
                  ? AppIcon.sendActivity
                  : AppIcon.receiveActivity,
              color: AppColor.primaryColor,
              width: 32.w,
            
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
                          state,
                          style: AppFont.medium14
                              .copyWith(color:  Theme.of(context).indicatorColor,),
                        ),
                        4.0.width,
                        Text(
                          "(${activity.symbol == "" ? evm.selectedChain.value.symbol : activity.symbol})",
                          style: AppFont.medium14
                              .copyWith(color: AppColor.grayColor),
                        ),
                      ],
                    ),
                    Text(
                      "${(BigInt.parse(activity.value!).toDouble() / pow(10, 18)).toStringAsFixed(5)} ${activity.symbol == "" ? evm.selectedChain.value.symbol : activity.symbol}",
                      style:
                          AppFont.medium14.copyWith(color:  Theme.of(context).indicatorColor,),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Confirmed",
                      style: AppFont.medium12
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    Text(
                      DateFormat("MMM dd 'at' h:mm a").format(
                          DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(activity.timeStamp!) * 1000)
                              .toLocal()),
                      style:
                          AppFont.reguler12.copyWith(color: AppColor.grayColor),
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
