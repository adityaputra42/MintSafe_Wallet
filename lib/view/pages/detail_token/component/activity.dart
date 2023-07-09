import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';
import 'package:mintsafe_wallet/view/pages/detail_token/component/detail_activity.dart';

class Activity extends StatelessWidget {
  const Activity({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardActivity() {
      return GestureDetector(
        onTap: () {
          Get.to(() => const DetailActivity());
        },
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              padding: EdgeInsets.all(8.h),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color:AppColor.secondaryColor),
              child: Image.asset(AppIcon.smartContractCall,color: AppColor.primaryColor,),
            ),
            16.0.width,
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Smart Contract Call",
                      style: AppFont.medium16,
                    ),
                    Text(
                      "0.00 ETH",
                      style:
                          AppFont.medium16.copyWith(color: AppColor.redColor),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "To : 0xf57229.....8dg82s8",
                      style: AppFont.reguler14
                          .copyWith(color: AppColor.grayColor),
                    ),
                    Text(
                      DateFormat("MMM dd, yyyy").format(DateTime.now()),
                      style: AppFont.reguler14
                          .copyWith(color: AppColor.grayColor),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      );
    }

    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: cardActivity(),
      ),
      itemCount: 2,
    ));
  }
}
