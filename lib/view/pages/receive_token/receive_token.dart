import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
              style: AppFont.medium14
                  .copyWith(fontSize: 20, color: AppColor.textDark),
            ),
            24.0.height,
            const Warning(
                warning:
                    "Send only ERC-20 to this address, or you might loose your funds."),
            36.0.height,
            Container(
              width: double.infinity,
              height: 382.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 1, blurRadius: 1, color: Colors.black12)
                  ],
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColor.cardDark),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 220.w,
                    height: 220.w,
                    padding: EdgeInsets.all(26.h),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.primaryColor.withOpacity(0.25)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.cardLight),
                      child: QrImageView(
                        data: '0xffjs67HKuydy32sdsjkajsd8712124jd343da6ge7',
                        version: QrVersions.auto,
                        size: 240.h,
                        gapless: false,
                      ),
                    ),
                  ),
                  32.0.height,
                  Text(
                    "0xffjs67HKuydy32sdsjkajsd8712124jd343d",
                    style:
                        AppFont.medium16.copyWith(color: AppColor.primaryColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Receive ETH",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: Stack(
        children: [
          SizedBox(
              width: ScreenUtil().screenWidth,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              )),
          body(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: AppColor.cardDark,
            boxShadow: const [
              BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black12)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryButton(
              width: MediaQuery.of(context).size.width * 0.43,
              title: "Copy",
              icon: Icon(
                Icons.copy_rounded,
                size: 24.h,
                color: AppColor.textDark,
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
