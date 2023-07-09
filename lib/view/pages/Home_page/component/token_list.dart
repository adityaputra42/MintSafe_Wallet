import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';
import 'package:mintsafe_wallet/view/pages/add_token/add_token.dart';
import 'package:mintsafe_wallet/view/pages/detail_token/detail_token.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

class TokenList extends StatelessWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardToken() {
      return GestureDetector(
        onTap: () {
          Get.to(() => DetailToken());
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          height: 60.h,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 0.3, spreadRadius: 0.5, color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.cardDark),
          child: Row(
            children: [
              ClipPolygon(
                sides: 6,
                rotate: 0,
                child: Container(
                    padding: EdgeInsets.all(1.h),
                    color: AppColor.cardDark,
                    child: Image.asset(AppImage.eth)),
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
                          "Ethereum",
                          style: AppFont.medium16
                              .copyWith(color: AppColor.textDark),
                        ),
                        Text(
                          NumberFormat.currency(
                                  symbol: '', decimalDigits: 4, locale: "en_US")
                              .format(0),
                          style: AppFont.medium16.copyWith(
                              fontFamily: "Roboto", color: AppColor.textDark),
                        )
                      ],
                    ),
                    4.0.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${NumberFormat.currency(symbol: '', decimalDigits: 2, locale: "en_US").format(1813.98)}",
                              style: AppFont.reguler14.copyWith(
                                  color: AppColor.grayColor,
                                  fontFamily: "Roboto"),
                            ),
                            4.0.width,
                            Icon(
                              Icons.arrow_outward_rounded,
                              size: 16.h,
                              color: AppColor.primaryColor,
                            ),
                            Text(
                              "0.10%",
                              style: AppFont.reguler14
                                  .copyWith(color: AppColor.primaryColor),
                            ),
                          ],
                        ),
                        Text(
                          "\$${NumberFormat.currency(symbol: '', decimalDigits: 2, locale: "en_US").format(0)}",
                          style: AppFont.reguler14.copyWith(
                              color: AppColor.grayColor, fontFamily: "Roboto"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0.5.h),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: cardToken(),
            ),
            itemCount: 2,
          )),
          SecondaryButton(
            title: "Add Token",
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 24.h,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              Get.to(() => AddTokenPage());
            },
            margin: EdgeInsets.only(bottom: 16.h),
          )
        ],
      ),
    );
  }
}
