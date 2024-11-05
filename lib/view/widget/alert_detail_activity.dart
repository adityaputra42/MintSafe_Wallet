import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';
import 'package:web3_provider/web3_provider.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../domain/controller/evm_new_controller.dart';
import '../../utils/utils.dart';

class AlertDetailActivity extends StatelessWidget {
  AlertDetailActivity({super.key, required this.activity, required this.state});

  final EvmNewController evm = Get.find();
  final Activity activity;
  final String state;
  final ChromeSafariBrowser browser = ChromeSafariBrowser();
  @override
  Widget build(BuildContext context) {
    Widget content() {
      return Obx(() {
        return SizedBox(
          width: 430.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Theme.of(context).cardColor),
                child: Image.asset(
                    state == "Transfer"
                        ? AppIcon.sendActivity
                        : AppIcon.receiveActivity,
                    color: AppColor.primaryColor),
              ),
              8.0.height,
              Text(
                state == "Transfer"
                    ? 'Transfer ${activity.symbol == "" ? evm.selectedChain.value.symbol : activity.symbol}'
                    : 'Receive ${activity.symbol == "" ? evm.selectedChain.value.symbol : activity.symbol}',
                style: AppFont.semibold18.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
                textAlign: TextAlign.center,
              ),
              2.0.height,
              Text(
                '${BigInt.parse(activity.value!).toDouble() / pow(10, 18)} ${activity.symbol == "" ? evm.selectedChain.value.symbol : activity.symbol}',
                style: AppFont.semibold24.copyWith(
                  color: AppColor.primaryColor,
                ),
              ),
              16.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    'Confirmed',
                    style: AppFont.medium14.copyWith(
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    DateFormat("MMM dd 'at' h:mm a").format(
                        DateTime.fromMillisecondsSinceEpoch(
                                int.parse(activity.timeStamp!) * 1000)
                            .toLocal()),
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'From :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    MethodHelper()
                        .shortAddress(address: activity.from ?? '', length: 8),
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    MethodHelper()
                        .shortAddress(address: activity.to ?? '', length: 8),
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nonce :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    '#${activity.nonce}',
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Network Fee :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    '${BigInt.from(int.parse(activity.gas!) * int.parse(activity.gasPrice!)).toDouble() / pow(10, 18)} ${evm.selectedChain.value.symbol}',
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              12.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount :',
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                  Text(
                    '${(BigInt.parse(activity.value!).toDouble() / pow(10, 18)) + (BigInt.from(int.parse(activity.gas!) * int.parse(activity.gasPrice!)).toDouble() / pow(10, 18))} ${evm.selectedChain.value.symbol}',
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              32.0.height,
              SecondaryButton(
                title: "View on explorer",
                onPressed: () async {
                  await browser.open(
                      url: Uri.parse(
                          '${evm.selectedChain.value.explorer}/tx/${activity.hash}'));
                  browser.close();
                },
                height: 48,
              )
            ],
          ),
        );
      });
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      titlePadding: EdgeInsets.zero,
      // title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
