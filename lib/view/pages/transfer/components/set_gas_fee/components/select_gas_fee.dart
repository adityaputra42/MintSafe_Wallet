import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../../../domain/controller/transfer_controller.dart';

class SelectGasFee extends StatelessWidget {
  SelectGasFee({super.key});
  final Transfercontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget cardGasFee({
      required int index,
      required double fee,
      required String title,
    }) {
      return Obx(() {
        return GestureDetector(
          onTap: () {
            controller.changeIndexFee(index);
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.cardDark),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppFont.medium14.copyWith(color: AppColor.textDark),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '~ ${fee.toStringAsFixed(8)} ${controller.evm.selectedChain.value.symbol}',
                        style:
                            AppFont.medium14.copyWith(color: AppColor.textDark),
                      ),
                      16.0.width,
                      SizedBox(
                          width: 16.w,
                          height: 16.w,
                          child: Checkbox(
                            value: controller.selectedIndexFee.value == index
                                ? true
                                : false,
                            onChanged: (value) {},
                            activeColor: AppColor.primaryColor,
                            checkColor: AppColor.textDark,
                            hoverColor: AppColor.grayColor,
                            focusColor: AppColor.grayColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r)),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      });
    }

    return Column(
      children: [
        24.0.height,
        cardGasFee(
            index: 0, title: "Slow", fee: controller.networkFeeSlow.value),
        cardGasFee(
            index: 1,
            title: "Average",
            fee: controller.networkFeeAverage.value),
        cardGasFee(
            index: 2, title: "Fast", fee: controller.networkFeeFast.value),
      ],
    );
  }
}
