import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/utils/helper/method_helper.dart';
import 'package:mintsafe_wallet/view/pages/add_nft/add_nft.dart';
import 'package:mintsafe_wallet/view/pages/detail_nft/detail_group_nft.dart';
import '../../../../data/model/nft/nft_vew.dart';
import '../../../widget/widget.dart';

class NftList extends StatelessWidget {
  NftList({super.key});
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardNft(
      NftView nft,
    ) {
      return GestureDetector(
        onTap: () {
          Get.to(()=>DetailGroupNft(nftView: nft,));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 0.3, spreadRadius: 0.5, color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(8.r),
              color: Theme.of(context).cardColor),
          child: Row(
            children: [
              SizedBox(
                height: 42.h,
                width: 42.h,
                child: ClipPolygon(
                  sides: 6,
                  rotate: 0,
                  child: Container(
                      padding: EdgeInsets.all(1.h),
                      color: Theme.of(context).cardColor,
                      child: Image.memory(
                        MethodHelper()
                            .convertBase64ToUint8List(nft.image ?? ''),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              8.0.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nft.name ?? "",
                          style: AppFont.medium14.copyWith(
                              color: Theme.of(context).indicatorColor),
                        ),
                        Text(
                          "${nft.length} Items",
                          style: AppFont.medium14.copyWith(
                              fontFamily: "Roboto",
                              color: Theme.of(context).indicatorColor),
                        )
                      ],
                    ),
                    //
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Expanded(child: Obx(() {
      return Column(
        children: [
          Expanded(
            child: evm.listUniqueNft.isEmpty
                ? const Center(
                    child: Empty(title: "Add Your NFT"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 0.5.h),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: cardNft(evm.listUniqueNft[index]),
                    ),
                    itemCount: evm.listUniqueNft.length,
                  ),
          ),
          // 8.0.height,
          SecondaryButton(
            title: "Add NFT",
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 24.h,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              Get.to(() => AddNft());
            },
            margin: EdgeInsets.only(bottom: 16.h),
          )
        ],
      );
    }));
  }
}
