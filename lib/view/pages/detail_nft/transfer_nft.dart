// ignore_for_file: use_build_context_synchronously

import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import '../../../config/config.dart';
import '../../../data/model/nft/nft.dart';
import '../../../domain/controller/evm_new_controller.dart';
import '../../../domain/controller/nft_controller.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';
import '../scan/scann_page.dart';
import 'transfer_nft_confirm.dart';

class TransferNft extends StatelessWidget {
  TransferNft({super.key, required this.nft});
  final Nft nft;
  final EvmNewController evm = Get.find();
  final NftController controller =
      Get.isRegistered<NftController>() ? Get.find() : Get.put(NftController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        appBar: WidgetHelper.appBar(
            context: context,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Theme.of(context).indicatorColor,
                    size: 24.h,
                  ),
                ),
                16.0.width,
                Text("NFT Transfer",
                    style: AppFont.medium16
                        .copyWith(color: Theme.of(context).indicatorColor)),
              ],
            )),
        body: Stack(
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                16.0.height,
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(16.w),
                    height: 98.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context).dialogBackgroundColor),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.memory(
                              MethodHelper().convertBase64ToUint8List(
                                nft.imageByte ?? '',
                              ),
                              width: 48.w,
                              height: 48.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          8.0.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  nft.name ?? '',
                                  style: AppFont.semibold14.copyWith(
                                      color: Theme.of(context).indicatorColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                4.0.height,
                                Text("#${nft.tokenId}",
                                    style: AppFont.medium12.copyWith(
                                      color: AppColor.grayColor,
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(16.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From :",
                          style: AppFont.medium14.copyWith(
                              color: Theme.of(context).indicatorColor),
                        ),
                        8.0.height,
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 10.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Theme.of(context).dialogBackgroundColor),
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Blockies(
                                    size: 0.6,
                                    data: evm.selectedAddress.value.address ??
                                        "-",
                                    shape: BlockiesShape.circle),
                              ),
                              8.0.width,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    evm.selectedAddress.value.name ?? "",
                                    style: AppFont.semibold14.copyWith(
                                        color:
                                            Theme.of(context).indicatorColor),
                                  ),
                                  4.0.height,
                                  Text(
                                    "${evm.selectedAddress.value.balance ?? 0.0} \$${evm.selectedChain.value.symbol}",
                                    style: AppFont.medium12
                                        .copyWith(color: AppColor.grayColor),
                                  )
                                ],
                              )),
                            ],
                          ),
                        ),
                        16.0.height,
                        InputText(
                          title: "To :",
                          hintText: "Enter your receiver",
                          controller: controller.addressController,
                          onChange: controller.checkAddressSent,
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              8.0.width,
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ScannPage(
                                        scanType: ScanType.addressNft,
                                      ));
                                },
                                child: Image.asset(
                                  AppIcon.scanIcon,
                                  width: 24.w,
                                ),
                              ),
                              16.0.width,
                            ],
                          ),
                        ),
                        32.0.height,
                        Expanded(
                          child: Obx(() {
                            return evm.anotherAddressList.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Your Accounts :",
                                        style: AppFont.medium14.copyWith(
                                          color:
                                              Theme.of(context).indicatorColor,
                                        ),
                                      ),
                                      16.0.height,
                                      Expanded(
                                        child: ListView(
                                          children: List.generate(
                                              evm.anotherAddressList.length,
                                              (index) => Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 16.h),
                                                    child: cardAnotherAccount(
                                                        context,
                                                        address:
                                                            evm.anotherAddressList[
                                                                index]),
                                                  )),
                                        ),
                                      )
                                    ],
                                  );
                          }),
                        ),
                        PrimaryButton(
                            title: "Next",
                            disable: controller.buttonNext.value,
                            loading: controller.isNextLoading.value,
                            onPressed: () async {
                              await controller.getNetworkFee(nft: nft);
                              Get.to(() => TransferNftConfirm(
                                  controller: controller, nft: nft));
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget cardAccount(BuildContext context, {required Address address}) {
    return GestureDetector(
      onTap: () async {
        if (address.address != evm.selectedAddress.value.address) {
          evm.changeAddress(address);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          width: double.infinity,
          decoration: BoxDecoration(
              color: address.address == evm.selectedAddress.value.address
                  ? AppColor.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              border: Border(
                  left: BorderSide(
                width: 3.h,
                color: address.address == evm.selectedAddress.value.address
                    ? AppColor.primaryColor
                    : Colors.transparent,
              ))),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Blockies(
                    size: 0.6,
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
                    style: AppFont.semibold14.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                  4.0.height,
                  Text(
                    "${address.balance} \$${evm.selectedChain.value.symbol}",
                    style: AppFont.medium12.copyWith(color: AppColor.grayColor),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardAnotherAccount(BuildContext context, {required Address address}) {
    return GestureDetector(
      onTap: () {
        controller.setAddressSent(address);
      },
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Blockies(
                size: 0.6,
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
                style: AppFont.semibold14.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
              4.0.height,
              Text(
                "${address.balance} \$${evm.selectedChain.value.symbol}",
                style: AppFont.medium12.copyWith(color: AppColor.grayColor),
              )
            ],
          )),
        ],
      ),
    );
  }
}
