import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/utils/helper/method_helper.dart';
import 'package:mintsafe_wallet/view/pages/detail_nft/transfer_nft.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../data/model/nft/nft.dart';
import '../../../utils/helper/widget_helper.dart';

class DetailNft extends StatelessWidget {
  DetailNft({super.key, required this.nft});
  final Nft nft;
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              Text(nft.name ?? '',
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor)),
            ],
          )),
      body: Stack(children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          child: Image.asset(
            AppImage.maskHome,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.0.height,
              Container(
                width: double.infinity,
                height: ScreenUtil().screenWidth - 24.w,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Theme.of(context).cardColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.memory(
                          MethodHelper()
                              .convertBase64ToUint8List(nft.imageByte ?? ''),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    16.0.height,
                    Text(
                      nft.name ?? '',
                      style: AppFont.semibold20
                          .copyWith(color: Theme.of(context).indicatorColor),
                    )
                  ],
                ),
              ),
              16.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Contract Address :",
                    style: AppFont.medium14.copyWith(color: AppColor.grayColor),
                  ),
                  Row(
                    children: [
                      Text(
                        MethodHelper().shortAddress(
                            address: nft.contractAddress ?? '', length: 8),
                        style: AppFont.medium14
                            .copyWith(color: Theme.of(context).indicatorColor),
                      ),
                      8.0.width,
                      Icon(
                        Icons.copy_rounded,
                        size: 16.w,
                        color: AppColor.primaryColor,
                      )
                    ],
                  )
                ],
              ),
              8.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Token Id : ",
                    style: AppFont.medium14.copyWith(color: AppColor.grayColor),
                  ),
                  Row(
                    children: [
                      Text(
                        "#${nft.tokenId}",
                        style: AppFont.medium14
                            .copyWith(color: Theme.of(context).indicatorColor),
                      ),
                      8.0.width,
                      Icon(
                        Icons.copy_rounded,
                        size: 16.w,
                        color: AppColor.primaryColor,
                      )
                    ],
                  )
                ],
              ),
              8.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Standart Token : ",
                    style: AppFont.medium14.copyWith(color: AppColor.grayColor),
                  ),
                  Text(
                    "ERC-721",
                    style: AppFont.medium14
                        .copyWith(color: Theme.of(context).indicatorColor),
                  )
                ],
              ),
              8.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mainnet : ",
                    style: AppFont.medium14.copyWith(color: AppColor.grayColor),
                  ),
                  Text(
                    "${evm.selectedChain.value.name}",
                    style: AppFont.medium14
                        .copyWith(color: Theme.of(context).indicatorColor),
                  )
                ],
              ),
              8.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Owner : ",
                    style: AppFont.medium14.copyWith(color: AppColor.grayColor),
                  ),
                  Row(
                    children: [
                      Text(
                        MethodHelper()
                            .shortAddress(address: nft.owner ?? '', length: 8),
                        style: AppFont.medium14
                            .copyWith(color: Theme.of(context).indicatorColor),
                      ),
                      8.0.width,
                      Icon(
                        Icons.copy_rounded,
                        size: 16.w,
                        color: AppColor.primaryColor,
                      )
                    ],
                  )
                ],
              ),
              const Spacer(),
              PrimaryButton(
                title: "Send",
                onPressed: () {
                  Get.to(() => TransferNft(nft: nft));
                },
                margin: EdgeInsets.only(bottom: 24.w, top: 8.h),
              )
            ],
          ),
        )
      ]),
    );
  }
}
