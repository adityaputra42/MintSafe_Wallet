import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/view/pages/transfer/transfer_page.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class SelectTokenPage extends StatelessWidget {
  const SelectTokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardToken() {
      return GestureDetector(
        onTap: () {
          Get.to(() => const TransferPage());
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          height: 60.h,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                spreadRadius: 0.4, blurRadius: 0.5.h, color: Colors.black12)
          ], borderRadius: BorderRadius.circular(12.r), color: Colors.white),
          child: Row(
            children: [
              ClipPolygon(
                sides: 6,
                rotate: 0,
                child: Container(
                    padding: EdgeInsets.all(1.h),
                    color: Colors.white,
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
                          style: AppFont.medium16,
                        ),
                        Text(
                          NumberFormat.currency(
                                  symbol: '', decimalDigits: 4, locale: "en_US")
                              .format(0),
                          style:
                              AppFont.medium16.copyWith(fontFamily: "Roboto"),
                        )
                      ],
                    ),
                    4.0.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ERC-20",
                          style: AppFont.reguler14.copyWith(
                              color: AppColor.grayColor, fontFamily: "Roboto"),
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

    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            16.0.height,
            const TabbarCustom(
                titles: ["BNB Chain", "Ethereum", "Arbitreum", "Polygon"],
                selectedIndex: 0),
            16.0.height,
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: cardToken(),
              ),
              itemCount: 5,
            ))
          ],
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
            "Select Asset",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: body(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Couldn't find your token?\nTap the below button to add.",
            style: AppFont.reguler12.copyWith(
              color: AppColor.grayColor,
            ),
            textAlign: TextAlign.center,
          ),
          SecondaryButton(
            title: "Add Token",
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 24.h,
              color: AppColor.primaryColor,
            ),
            onPressed: () {},
            margin: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 36.h),
          ),
        ],
      ),
    );
  }
}
