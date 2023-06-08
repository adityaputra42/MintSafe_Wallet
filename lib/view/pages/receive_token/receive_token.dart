import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/warning.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../widget/widget.dart';

class ReceiveTokenPage extends StatelessWidget {
  const ReceiveTokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            16.0.height,
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
            16.0.height,
            Text(
              "ETH (ERC-20)",
              style: AppFont.medium14.copyWith(fontSize: 20),
            ),
            24.0.height,
            const Warning(
                warning:
                    "Send only ERC-20 to this address, or you might loose your funds."),
            36.0.height,
            Container(
              width: double.infinity,
              height: 382.h,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 0.5.h,
                        blurRadius: 0.5.h,
                        color: Colors.black12)
                  ],
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  QrImageView(
                    data: '0xffjs67HKuydy32sdsjkajsd8712124jd343da6ge7',
                    version: QrVersions.auto,
                    size: 240.h,
                    gapless: false,
                    // embeddedImage: AssetImage(AppImage.logo),
                    // embeddedImageStyle: QrEmbeddedImageStyle(
                    //   size: Size(80, 80),
                    // ),
                  ),
                  36.0.height,
                  Text(
                    "0xffjs67HKuydy32sdsjkajsd8712124jd343d...",
                    style: AppFont.reguler16,
                  ),
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
            "Receive ETH",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: body(),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(right: 24.w, left: 24.w, bottom: 36.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryButton(
              width: MediaQuery.of(context).size.width * 0.43,
              title: "Copy",
              icon: Icon(
                Icons.copy_rounded,
                size: 24.h,
                color: AppColor.white,
              ),
              onPressed: () {},
            ),
            SecondaryButton(
              width: MediaQuery.of(context).size.width * 0.43,
              title: "Share",
              icon: Icon(
                Icons.share,
                size: 24.h,
                color: AppColor.primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
