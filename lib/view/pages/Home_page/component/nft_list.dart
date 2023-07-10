import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import '../../../widget/widget.dart';

class NftList extends StatelessWidget {
  const NftList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardNft() {
      return Container(
        // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        height: 220.h,
        width: MediaQuery.of(context).size.width * 0.425,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.3.h, spreadRadius: 0.3.h, color: Colors.black12)
            ],
            borderRadius: BorderRadius.circular(16.r),
            image: const DecorationImage(
                image: AssetImage(AppImage.nft), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            height: 54.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.r), bottom: Radius.circular(16.r)),
                gradient: LinearGradient(colors: [
                  AppColor.textLight.withOpacity(0.2),
                  AppColor.textLight.withOpacity(0.6),
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "OpenPad AI Launchpad",
                  style: AppFont.medium14.copyWith(color: AppColor.textDark),overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "2 Items",
                  style: AppFont.reguler12.copyWith(color: AppColor.textDark),
                )
              ],
            ),
          ),
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
          onPressed: () {},
          margin: EdgeInsets.only(bottom: 16.h),
        )
      ],
    ));
  }
}
