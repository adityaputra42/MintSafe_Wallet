import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/domain/controller/transfer_controller.dart';
import 'package:mintsafe_wallet/view/pages/transfer/set_amount.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';
import '../change_wallet/change_wallet.dart';
import 'components/set_gas_fee/set_gas_fee.dart';

enum AssetType { coin, token }

class ChooseReceiver extends StatefulWidget {
  const ChooseReceiver({super.key, required this.assetType, this.token});
  final AssetType assetType;
  final SelectedToken? token;
  @override
  State<ChooseReceiver> createState() => _ChooseReceiverState();
}

class _ChooseReceiverState extends State<ChooseReceiver> {
  late final Transfercontroller controller;
  final EvmNewController evm = Get.find();

  @override
  void initState() {
    controller = Get.put(Transfercontroller(token: widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cardAnotherAccount(BuildContext context,
        {required Address address}) {
      return GestureDetector(
        onTap: () {
          controller.setAddressSent(address);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.w,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.cardDark,
              border: Border.all(
                  width: 1.w,
                  color: address.address == evm.selectedAddress.value.address
                      ? AppColor.primaryColor
                      : Colors.transparent)),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 2.h, color: AppColor.primaryColor)),
                child: Blockies(
                    size: 0.55,
                    data: address.address ?? "-",
                    shape: BlockiesShape.circle),
              ),
              8.0.width,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name ?? "",
                    style: AppFont.medium14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                  4.0.height,
                  Text(
                    widget.assetType == AssetType.token
                        ? "${controller.evm.tokenSelected.singleWhere(
                              (element) =>
                                  element.walletAddress == address.address &&
                                  element.contractAddress ==
                                      widget.token?.contractAddress,
                              orElse: () => SelectedToken(),
                            ).balance ?? 0} \$${controller.selectedToken.value.symbol}"
                        : "${address.balance} \$${evm.selectedChain.value.symbol}",
                    style: AppFont.medium12.copyWith(color: AppColor.grayColor),
                  )
                ],
              )),
            ],
          ),
        ),
      );
    }

    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Obx(() {
          return Column(
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
                            child: Image.asset(widget.assetType ==
                                    AssetType.coin
                                ? (evm.selectedChain.value.logo ?? AppImage.eth)
                                : (widget.token?.logo ?? AppImage.eth))),
                      ),
                    ),
                    8.0.width,
                    Expanded(
                      child: Text(
                        widget.assetType == AssetType.coin
                            ? (evm.selectedChain.value.name ?? '')
                            : (widget.token?.name ?? ''),
                        style:
                            AppFont.medium16.copyWith(color: AppColor.textDark),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    8.0.width,
                    Text(
                      widget.assetType == AssetType.coin
                          ? (evm.selectedChain.value.symbol ?? '')
                          : (widget.token?.symbol ?? ''),
                      style:
                          AppFont.reguler14.copyWith(color: AppColor.grayColor),
                    ),
                  ],
                ),
              ),
              16.0.height,
              Text(
                "From",
                style: AppFont.medium14.copyWith(color: AppColor.textDark),
              ),
              8.0.height,
              GestureDetector(
                onTap: () {
                  Get.to(() => ChangeWallet());
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColor.cardDark,
                    borderRadius: BorderRadius.circular(8.r),
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
                      8.0.width,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${evm.selectedAddress.value.name} ${evm.selectedAddress.value.id}",
                              // MethodHelper().shortAddress(
                              //     address:
                              //         evm.selectedAddress.value.address ?? '',
                              //     length: 8),
                              style: AppFont.medium14
                                  .copyWith(color: AppColor.textDark),
                            ),
                            4.0.height,
                            Text(
                              widget.assetType == AssetType.coin
                                  ? "${evm.selectedAddress.value.balance} ${evm.selectedChain.value.symbol}"
                                  : "${widget.token?.balance} ${widget.token?.symbol}",
                              style: AppFont.reguler12
                                  .copyWith(color: AppColor.grayColor),
                            ),
                          ],
                        ),
                      ),
                      8.0.width,
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24.w,
                        color: AppColor.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
              16.0.height,
              InputText(
                title: "To",
                hintText: "Receive Address",
                controller: controller.addressController,
                onChange: controller.checkAddressSent,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    8.0.width,
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 24.h,
                    ),
                    16.0.width
                  ],
                ),
              ),
              32.0.height,
              Expanded(
                child: Obx(() {
                  return evm.anotherAddressList.isEmpty
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Accounts :",
                              style: AppFont.medium14.copyWith(
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                            16.0.height,
                            Expanded(
                              child: ListView(
                                children: List.generate(
                                    evm.anotherAddressList.length,
                                    (index) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 16.h),
                                          child: cardAnotherAccount(context,
                                              address: evm
                                                  .anotherAddressList[index]),
                                        )),
                              ),
                            )
                          ],
                        );
                }),
              ),
            ],
          );
        }),
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
              "Transfer ${widget.assetType == AssetType.coin ? evm.selectedChain.value.symbol : widget.token?.symbol}",
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
          disable: controller.buttonNext.value,
          title: "Continue",
          onPressed: () async {
            await controller.getTotalAmount();
            controller.getNetworkFee();
            Get.to(() => SetAmout(
                  assetType: widget.assetType,
                ));
          },
          margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
        ),
      );
    });
  }
}
