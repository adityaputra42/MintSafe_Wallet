import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../data/model/nft/nft.dart';
import '../../../domain/controller/evm_new_controller.dart';
import '../../../domain/controller/nft_controller.dart';
import '../../widget/widget.dart';

class TransferNftConfirm extends StatelessWidget {
  TransferNftConfirm({
    super.key,
    required this.controller,
    required this.nft,
  });
  final Nft nft;
  final NftController controller;
  final EvmNewController evm = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
              Text("NFT Transfer Confirmation",
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor)),
            ],
          )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Row(
          children: [
            Expanded(
                child: SecondaryButton(
                    title: "Cancel",
                    onPressed: () {
                      Get.back();
                    })),
            8.0.width,
            Expanded(
                child: PrimaryButton(
                    title: "Confirm",
                    loading: controller.isloadingTransfer.value,
                    onPressed: () async {
                      await controller.transferNft(
                          to: controller.addressController.text, nft: nft);
                    }))
          ],
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            child: Image.asset(
              AppImage.maskHome,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: SingleChildScrollView(
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context).cardColor),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 48.h,
                            width: 48.h,
                            child: ClipPolygon(
                              sides: 6,
                              rotate: 0,
                              child: Container(
                                  padding: EdgeInsets.all(1.h),
                                  color: Theme.of(context).cardColor,
                                  child: Image.memory(
                                    MethodHelper().convertBase64ToUint8List(
                                        nft.imageByte ?? ''),
                                    fit: BoxFit.cover,
                                  )),
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
                    ),
                    16.0.height,
                    Text(
                      "From",
                      style: AppFont.medium14
                          .copyWith(color: Theme.of(context).indicatorColor),
                    ),
                    8.0.height,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context).cardColor),
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
                                data: evm.selectedAddress.value.address ?? "-",
                                shape: BlockiesShape.circle),
                          ),
                          8.0.width,
                          Expanded(
                            child: Text(
                              MethodHelper().shortAddress(
                                address: nft.owner ?? '',length: 8
                              ),
                              style: AppFont.semibold14.copyWith(
                                  color: Theme.of(context).indicatorColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.0.height,
                    Text(
                      "To",
                      style: AppFont.medium14
                          .copyWith(color: Theme.of(context).indicatorColor),
                    ),
                    8.0.height,
                    Container(
                      width: double.infinity,
                     
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context).cardColor),
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
                                data: controller.addressController.text,
                                shape: BlockiesShape.circle),
                          ),
                          8.0.width,
                          Expanded(
                            child: Text(
                              MethodHelper().shortAddress(
                                  address: controller.addressController.text, length: 8),
                              style: AppFont.semibold14.copyWith(
                                  color: Theme.of(context).indicatorColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.0.height,
                    Text(
                      "Contract Address",
                      style: AppFont.medium14
                          .copyWith(color: Theme.of(context).indicatorColor),
                    ),
                    8.0.height,
                    Container(
                      width: double.infinity,
                     
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context).cardColor),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            MethodHelper().shortAddress(
                              address: nft.contractAddress ?? '',length: 12
                            ),
                            style: AppFont.semibold14.copyWith(
                                color: Theme.of(context).indicatorColor),
                            overflow: TextOverflow.ellipsis,
                          )),
                          8.0.width,
                          GestureDetector(
                            onTap: () {
                              MethodHelper()
                                  .handleCopy(data: nft.contractAddress ?? '');
                            },
                            child: Icon(
                              Icons.copy_rounded,
                              size: 20.h,
                              color: AppColor.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    16.0.height,
                    Text(
                      "Gas Fee",
                      style: AppFont.medium14
                          .copyWith(color: Theme.of(context).indicatorColor),
                    ),
                    8.0.height,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Theme.of(context).cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Estimated Gas Fee",
                                  style: AppFont.medium14.copyWith(
                                    color: Theme.of(context).indicatorColor,
                                  )),
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
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              '~${controller.networkFee.value.toStringAsFixed(8)} ${evm.selectedChain.value.symbol}',
                              style: AppFont.medium14.copyWith(
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    24.0.height,
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // void sheetGasFee(BuildContext context, NftController controller) {
  //   Get.bottomSheet(
  //     Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
  //       child: Obx(() {
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'Gas Fee',
  //               style: AppFont.semibold16.copyWith(
  //                 color: Theme.of(context).indicatorColor,
  //               ),
  //             ),
  //             16.0.height,
  //             DefaultTabController(
  //               length: 2,
  //               initialIndex: controller.selectedFee.value,
  //               child: TabBar(
  //                 padding: EdgeInsets.zero,
  //                 indicatorSize: TabBarIndicatorSize.tab,
  //                 indicatorColor: AppColor.primaryColor,
  //                 labelColor: Theme.of(context).cardColor,
  //                 labelStyle: AppFont.medium14,
  //                 indicatorWeight: 2.h,
  //                 unselectedLabelColor: AppColor.grayColor,
  //                 labelPadding: EdgeInsets.zero,
  //                 onTap: (value) {
  //                   controller.changeFee(value);
  //                 },
  //                 tabs: [
  //                   Tab(
  //                     iconMargin: EdgeInsets.only(bottom: 2.h),
  //                     text: "Recomended",
  //                   ),
  //                   Tab(
  //                     iconMargin: EdgeInsets.only(bottom: 2.h),
  //                     text: "Custom",
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             16.0.height,
  //             controller.selectedFee.value == 0
  //                 ? recommendedGasFee()
  //                 : customGasFee(),
  //             24.0.height,
  //             Row(
  //               children: [
  //                 Flexible(
  //                   child: SecondaryButton(
  //                     title: 'Cancel',
  //                     onPressed: () {
  //                       Get.back();
  //                     },
  //                   ),
  //                 ),
  //                 8.0.width,
  //                 Flexible(
  //                   child: PrimaryButton(
  //                     title: 'Confirm',
  //                     onPressed: () {
  //                       controller.saveFee();
  //                       Get.back();
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         );
  //       }),
  //     ),
  //     backgroundColor: Theme.of(context).cardColor,
  //     elevation: 0,
  //     isDismissible: true,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20.r),
  //         topRight: Radius.circular(20.r),
  //       ),
  //     ),
  //   );
  // }

  // Column customGasFee() {
  //   return Column(
  //     children: [
  //       InputText(
  //         title: 'Gas Limit',
  //         controller: controller.gasLimitController,
  //         keyboardType: TextInputType.number,
  //         hintText: "21000",
  //         inputFormatters: [
  //           FilteringTextInputFormatter.allow(
  //             RegExp('[0-9.,]'),
  //           ),
  //         ],
  //       ),
  //       24.0.height,
  //       InputText(
  //         title: 'Gas Price: (GWEI)',
  //         controller: controller.gasPriceController,
  //         keyboardType: TextInputType.number,
  //         hintText: "1 GWEI ≈ 0.00420000 ETH",
  //         inputFormatters: [
  //           FilteringTextInputFormatter.allow(
  //             RegExp('[0-9.,]'),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Widget recommendedGasFee() {
  //   return Column(
  //     children: [
  //       CardGasFeeNft(
  //         ontap: () {
  //           controller.changeIndexFee(0);
  //         },
  //         controller: controller,
  //         index: 0,
  //         title: 'Slow',
  //         fee: controller.networkFeeSlow.value,
  //         name: evm.selectedChain.value.symbol ?? "",
  //       ),
  //       16.0.height,
  //       CardGasFeeNft(
  //         title: 'Normal',
  //         index: 1,
  //         ontap: () {
  //           controller.changeIndexFee(1);
  //         },
  //         controller: controller,
  //         fee: controller.networkFeeAverage.value,
  //         name: evm.networkController.selectedChain.value.symbol ?? "",
  //       ),
  //       16.0.height,
  //       CardGasFeeNft(
  //         title: 'Fast',
  //         index: 2,
  //         ontap: () {
  //           controller.changeIndexFee(2);
  //         },
  //         controller: controller,
  //         fee: controller.networkFeeFast.value,
  //         name: evm.networkController.selectedChain.value.symbol ?? "",
  //       ),
  //     ],
  //   );
  // }
}
