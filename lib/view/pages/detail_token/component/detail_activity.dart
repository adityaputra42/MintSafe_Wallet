import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../utils/utils.dart';

class DetailActivity extends StatelessWidget {
  const DetailActivity({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardWallet() {
      return Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: AppColor.primaryColor.withOpacity(0.15))
            ],
            color: AppColor.primaryColor,
            image: const DecorationImage(
                image: AssetImage(AppImage.masking), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Image.asset(AppImage.eth)),
                ),
              ),
              8.0.height,
              Text(
                "- ${NumberFormat.currency(symbol: '', decimalDigits: 4, locale: "en_US").format(0)} ETH",
                style: AppFont.semibold24.copyWith(
                  color: AppColor.textDark,
                ),
              ),
              Text(
                  "~\$${NumberFormat.currency(symbol: '', decimalDigits: 2, locale: "en_US").format(0)}",
                  style: AppFont.reguler16.copyWith(
                    color: AppColor.textDark,
                  )),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgLight,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textLight,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Smart Contract Call Ethereum Mainet",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            16.0.height,
            cardWallet(),
            24.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date",
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                ),
                Text(
                  DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
                  style: AppFont.medium14,
                ),
              ],
            ),
            16.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "State",
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                ),
                Text(
                  "Succes",
                  style:
                      AppFont.medium14.copyWith(color: AppColor.primaryColor),
                ),
              ],
            ),
            16.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "To",
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                ),
                Text(
                  "0xff2342......sdhe72kjsjksdj",
                  style: AppFont.medium14,
                ),
              ],
            ),
            16.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TxID",
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                ),
                Text(
                  "0xds7hfjwq87.....aas89has7",
                  style: AppFont.medium14,
                ),
              ],
            ),
            16.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Network Fee",
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                ),
                Text(
                  "${NumberFormat.currency(symbol: '', decimalDigits: 4, locale: "en_US").format(0)} ETH",
                  style: AppFont.medium14,
                ),
              ],
            ),
            36.0.height,
            PrimaryButton(title: "See on Explorer", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
