import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/nft/nft.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/view/pages/detail_nft/detail_nft.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../data/model/nft/nft_vew.dart';
import '../../../utils/helper/helper.dart';

class DetailGroupNft extends StatelessWidget {
  const DetailGroupNft({super.key, required this.nftView});
  final NftView nftView;
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
              Text("Detail NFT",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              24.0.height,
              Row(
                children: [
                  SizedBox(
                    height: 96.h,
                    width: 96.h,
                    child: ClipPolygon(
                      sides: 6,
                      rotate: 0,
                      child: Container(
                        padding: EdgeInsets.all(6.h),
                        color: Theme.of(context).cardColor,
                        child: ClipPolygon(
                          sides: 6,
                          rotate: 0,
                          child: Container(
                              padding: EdgeInsets.all(1.h),
                              color: Theme.of(context).cardColor,
                              child: Image.memory(
                                MethodHelper().convertBase64ToUint8List(
                                    nftView.image ?? ''),
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                  ),
                  8.0.width,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nftView.name ?? '',
                        style: AppFont.medium16
                            .copyWith(color: Theme.of(context).indicatorColor),
                      ),
                      4.0.width,
                      Text(
                        "Owned : ${nftView.length}",
                        style: AppFont.medium14
                            .copyWith(color: AppColor.grayColor),
                      ),
                      4.0.width,
                      Row(
                        children: [
                          Text(
                            MethodHelper().shortAddress(
                                address: nftView.contract ?? '', length: 8),
                            style: AppFont.medium14
                                .copyWith(color: AppColor.grayColor),
                          ),
                          8.0.width,
                          Icon(
                            Icons.copy_rounded,
                            color: AppColor.grayColor,
                            size: 16.w,
                          )
                        ],
                      ),
                    ],
                  ))
                ],
              ),
              32.0.height,
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      runSpacing: 16.w,
                      spacing: 16.w,
                      children: List.generate(nftView.listNft!.length,
                          (index) => cardNft(nftView.listNft![index], context)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget cardNft(Nft nft, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(DetailNft(nft: nft));
      },
      child: Container(
        height: 220.h,
        width: MediaQuery.of(context).size.width * 0.425,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.3.h, spreadRadius: 0.3.h, color: Colors.black12)
            ],
            borderRadius: BorderRadius.circular(12.r),
            color: Theme.of(context).cardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(6.h),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8.r),
                  bottom: Radius.circular(4.r),
                ),
                child: Image.memory(
                  MethodHelper().convertBase64ToUint8List(
                    nft.imageByte ?? '',
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nft.name ?? '',
                    style: AppFont.medium14
                        .copyWith(color: Theme.of(context).indicatorColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "#${nft.tokenId}",
                    style: AppFont.reguler12
                        .copyWith(color: Theme.of(context).indicatorColor),
                  ),
                  8.0.height,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
