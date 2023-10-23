import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../utils/utils.dart';

class AlertDetailActivity extends StatelessWidget {
  const AlertDetailActivity({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content() {
      return SizedBox(
        width: 430.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              padding: EdgeInsets.all(8.h),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColor.cardDark),
              child: Image.asset(
                AppIcon.receiveActivity,
                color: AppColor.textDark,
              ),
            ),
            8.0.height,
            Text(
              "Transfer",
              // state == "Send"
              //     ? 'Sent ${activity.symbol == "" ? evm.networkController.selectedChain.value.symbol : activity.symbol}'
              //     : 'Receive ${activity.symbol == "" ? evm.networkController.selectedChain.value.symbol : activity.symbol}',
              style: AppFont.semibold18.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
              textAlign: TextAlign.center,
            ),
            2.0.height,
            Text(
              "0.0122 ETH",
              // '${BigInt.parse(activity.value!).toDouble() / pow(10, 18)} ${activity.symbol == "" ? evm.networkController.selectedChain.value.symbol : activity.symbol}',
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
                  'Mar 16 at 0:34 am',
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
                  "0xhfjhwq...hs87dtq8",
                  // shortAddress(
                  //   activity.from ?? '',
                  // ),
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
                  "0xhfjhwq...hs87dtq8",
                  // shortAddress(
                  //   activity.to ?? '',
                  // ),
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
                  '#${1}',
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
                  '0.00000012 ETH',
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
                  '0.0001212 ETH',
                  style: AppFont.medium14.copyWith(
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
              ],
            ),
            32.0.height,
            SecondaryButton(
              title: "View on explorer",
              onPressed: () {},
              height: 48,
            )
          ],
        ),
      );
    }

    return AlertDialog(
      backgroundColor: AppColor.bgDark,
      titlePadding: EdgeInsets.zero,
      // title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
