import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/transfer_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../config/config.dart';
import '../../../data/src/src.dart';
import '../../../domain/controller/evm_new_controller.dart';
import '../../widget/primary_button.dart';
import 'choose_receiver.dart';

class ConfirmTransfer extends StatelessWidget {
  ConfirmTransfer({super.key, required this.assetType});
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
            36.0.height,
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60.h,
                    height: 60.h,
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
                  8.0.height,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        assetType == AssetType.coin
                            ? (evm.selectedChain.value.name ?? '')
                            : (controller.selectedToken.value.name ?? ''),
                        style:
                            AppFont.medium16.copyWith(color: AppColor.textDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.0.width,
                      Text(
                        "(${assetType == AssetType.coin ? (evm.selectedChain.value.symbol ?? '') : (controller.selectedToken.value.symbol ?? '')})",
                        style: AppFont.medium16
                            .copyWith(color: AppColor.grayColor),
                      ),
                    ],
                  ),
                  12.0.height,
                  Text(
                    "${controller.amountInput.value} ${assetType == AssetType.coin ? (evm.selectedChain.value.symbol ?? '') : (controller.selectedToken.value.symbol ?? '')}",
                    style: AppFont.semibold30
                        .copyWith(color: Theme.of(context).indicatorColor),
                  ),
                ],
              ),
            ),
            24.0.height,
            Text("From",
                style: AppFont.medium14.copyWith(color: AppColor.textDark)),
            8.0.height,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColor.cardDark,
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2.h, color: AppColor.primaryColor)),
                    child: Blockies(
                        size: 0.55,
                        data: evm.selectedAddress.value.address ?? "-",
                        shape: BlockiesShape.circle),
                  ),
                  12.0.width,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${evm.selectedAddress.value.name} ${evm.selectedAddress.value.id}",
                        style: AppFont.medium16.copyWith(
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      4.0.height,
                      Text(
                        MethodHelper().shortAddress(
                            address: evm.selectedAddress.value.address ?? "",
                            length: 8),
                        style: AppFont.medium14
                            .copyWith(color: AppColor.grayColor),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            16.0.height,
            Text("To",
                style: AppFont.medium14.copyWith(color: AppColor.textDark)),
            8.0.height,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.w,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColor.cardDark,
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: 2.h, color: AppColor.primaryColor)),
                    child: Blockies(
                        size: 0.55,
                        data: controller.addressController.text,
                        shape: BlockiesShape.circle),
                  ),
                  12.0.width,
                  Expanded(
                      child: Text(
                    MethodHelper().shortAddress(
                        address: controller.addressController.text, length: 8),
                    style: AppFont.medium16
                        .copyWith(color: Theme.of(context).indicatorColor),
                  )),
                ],
              ),
            ),
            16.0.height,
            Text("Gas fee",
                style: AppFont.medium14.copyWith(color: AppColor.textDark)),
            8.0.height,
            Container(
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
                    '~ ${controller.networkFee.value.toStringAsFixed(6)} ${evm.selectedChain.value.symbol}',
                    style: AppFont.medium14.copyWith(color: AppColor.textDark),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Obx(() {
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
              "Transfer ${assetType == AssetType.coin ? evm.selectedChain.value.symbol : controller.selectedToken.value.symbol}",
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
          title: "Confirm",
          loading: controller.transferLoading.value,
          onPressed: () async {
            await controller.sendTransaction();
          },
          margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
        ),
      );
    });
  }
}
