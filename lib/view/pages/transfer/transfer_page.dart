import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/view/pages/select_token.dart/select_token.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            GestureDetector(
              onTap: () => Get.to(() => const SelectTokenPage()),
              child: Container(
                width: double.infinity,
                height: 60.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 36.h,
                      height: 36.h,
                      child: ClipPolygon(
                        sides: 6,
                        rotate: 0,
                        child: Container(
                            padding: EdgeInsets.all(1.h),
                            color: Colors.transparent,
                            child: Image.asset(AppImage.eth)),
                      ),
                    ),
                    8.0.width,
                    Expanded(
                      child: Text(
                        "Ethereum",
                        style: AppFont.medium14,
                      ),
                    ),
                    8.0.width,
                    Text(
                      "ERC-20",
                      style: AppFont.reguler12
                          .copyWith(color: AppColor.darkerGray),
                    ),
                    8.0.width,
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.darkerGray,
                      size: 16.h,
                    )
                  ],
                ),
              ),
            ),
            16.0.height,
            InputText(
              title: "To",
              hintText: "Receive Address",
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  8.0.width,
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 24.h,
                  ),
                  16.0.width
                ],
              ),
            ),
            InputText(
              title: "Amount",
              hintText: "Receive amount",
              crossTitle: Text(
                "Available : ${NumberFormat.currency(symbol: '', decimalDigits: 4, locale: "en_US").format(0)} ETH",
                style: AppFont.reguler12,
              ),
            ),
            Text("Gas fee", style: AppFont.medium16),
            8.0.height,
            Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${NumberFormat.currency(symbol: '', decimalDigits: 6, locale: "en_US").format(0.000193)} ETH",
                          style: AppFont.medium14,
                        ),
                        Text(
                          "\$${NumberFormat.currency(symbol: '', decimalDigits: 2, locale: "en_US").format(0.092)}",
                          style: AppFont.reguler12.copyWith(
                            color: AppColor.darkerGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.0.width,
                  Text(
                    "3.00 GWEI",
                    style:
                        AppFont.reguler12.copyWith(color: AppColor.darkerGray),
                  ),
                  8.0.width,
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.darkerGray,
                    size: 16.h,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackText,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Transfer",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: body(),
      bottomNavigationBar: PrimaryButton(
        title: "Continue",
        onPressed: () {},
        margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 36.h),
      ),
    );
  }
}
