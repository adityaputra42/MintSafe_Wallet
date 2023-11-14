import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/domain/controller/transfer_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../config/config.dart';
import '../../../data/src/src.dart';
import '../../../domain/controller/evm_new_controller.dart';
import '../../widget/input_text.dart';
import '../../widget/primary_button.dart';
import 'choose_receiver.dart';
import 'components/set_gas_fee/set_gas_fee.dart';

class SetAmout extends StatelessWidget {
  SetAmout({super.key, required this.assetType});
  final AssetType assetType;

  final Transfercontroller controller = Get.find();
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            Text(
              "Asset",
              style: AppFont.medium14.copyWith(color: AppColor.textDark),
            ),
            8.0.height,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColor.cardDark,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 48.h,
                    height: 48.h,
                    child: ClipPolygon(
                      sides: 6,
                      rotate: 0,
                      child: Container(
                          padding: EdgeInsets.all(1.h),
                          color: Colors.transparent,
                          child: Image.asset(assetType == AssetType.coin
                              ? (evm.selectedChain.value.logo ?? AppImage.eth)
                              : (controller.selectedToken.value.logo ??
                                  AppImage.eth))),
                    ),
                  ),
                  8.0.width,
                  Expanded(
                    child: Text(
                      assetType == AssetType.coin
                          ? (evm.selectedChain.value.name ?? '')
                          : (controller.selectedToken.value.name ?? ''),
                      style:
                          AppFont.medium16.copyWith(color: AppColor.textDark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  8.0.width,
                  Text(
                    assetType == AssetType.coin
                        ? (evm.selectedChain.value.symbol ?? '')
                        : (controller.selectedToken.value.symbol ?? ''),
                    style:
                        AppFont.reguler14.copyWith(color: AppColor.grayColor),
                  ),
                ],
              ),
            ),
            16.0.height,
            InputText(
              title: "Amount",
              hintText: "Receive amount",
              controller: controller.amountController,
              onChange: (v) {
                controller.validateAmount();
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
              ],
            ),
            6.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Available : ${assetType == AssetType.coin ? evm.selectedAddress.value.balance : controller.selectedToken.value.balance} ${assetType == AssetType.coin ? evm.selectedChain.value.symbol : controller.selectedToken.value.symbol}",
                  style: AppFont.reguler12.copyWith(color: AppColor.textDark),
                ),
                GestureDetector(
                  onTap: () {
                    controller.useMaxAmount();
                  },
                  child: Text(
                    "Use Max Balance",
                    style:
                        AppFont.medium14.copyWith(color: AppColor.primaryColor),
                  ),
                )
              ],
            ),
            16.0.height,
            Text("Gas fee",
                style: AppFont.medium14.copyWith(color: AppColor.textDark)),
            8.0.height,
            GestureDetector(
              onTap: () => Get.to(() => SetGasFee()),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColor.cardDark,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Estimated Gas Fee",
                            style: AppFont.medium14
                                .copyWith(color: AppColor.textDark),
                          ),
                          4.0.height,
                          Text(
                              controller.selectedIndexFee.value == 0
                                  ? "Slow transactions"
                                  : controller.selectedIndexFee.value == 1
                                      ? "Normal transactions"
                                      : "Fast transactions",
                              style: AppFont.medium12
                                  .copyWith(color: AppColor.redColor)),
                        ],
                      ),
                    ),
                    8.0.width,
                    Text(
                      '${controller.networkFee.value.toStringAsPrecision(8)} ${evm.selectedChain.value.symbol}',
                      style:
                          AppFont.medium14.copyWith(color: AppColor.textDark),
                    ),
                    8.0.width,
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.textDark,
                      size: 16.h,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Transfer",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: Stack(
        children: [
          SizedBox(
              width: ScreenUtil().screenWidth,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              )),
          body(),
        ],
      ),
      bottomNavigationBar: PrimaryButton(
        title: "Continue",
        onPressed: () {},
        margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
      ),
    );
  }
}
