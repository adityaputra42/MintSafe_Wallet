import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/view/pages/add_nft/add_nft.dart';
import '../../../widget/widget.dart';

class NftList extends StatelessWidget {
  const NftList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardNft() {
      return Container(
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
                child: Image.asset(
                  AppImage.nft,
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
                    "OpenPad AI Launchpad",
                    style: AppFont.medium14
                        .copyWith(color: Theme.of(context).indicatorColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "2 Items",
                    style: AppFont.reguler12
                        .copyWith(color: Theme.of(context).indicatorColor),
                  ),
                  8.0.height,
                ],
              ),
            )
          ],
        ),
      );
    }

    return Expanded(
        child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                alignment: WrapAlignment.center,
                spacing: 16.h,
                runSpacing: 8.h,
                direction: Axis.horizontal,
                children: [
                  cardNft(),
                  cardNft(),
                ]),
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
    ));
  }
}
