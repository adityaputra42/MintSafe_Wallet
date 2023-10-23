import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/domain/controller/transfer_controller.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';
import 'components/set_gas_fee/set_gas_fee.dart';

class TransferPage extends StatelessWidget {
  TransferPage({super.key});
  final Transfercontroller controller = Get.put(Transfercontroller());
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
              child: Container(
                width: double.infinity,
                height: 54.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColor.cardDark,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 32.h,
                      height: 32.h,
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
                        style:
                            AppFont.medium14.copyWith(color: AppColor.textDark),
                      ),
                    ),
                    8.0.width,
                    Text(
                      "ETH",
                      style:
                          AppFont.reguler12.copyWith(color: AppColor.grayColor),
                    ),
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
            16.0.height,
            InputText(
              title: "Amount",
              hintText: "Receive amount",
              crossTitle: Text(
                "Available : ${NumberFormat.currency(symbol: '', decimalDigits: 4, locale: "en_US").format(0)} ETH",
                style: AppFont.reguler12.copyWith(color: AppColor.textDark),
              ),
            ),
            16.0.height,
            Text("Gas fee",
                style: AppFont.medium16.copyWith(color: AppColor.textDark)),
            8.0.height,
            GestureDetector(
              onTap: () => Get.to(() => SetGasFee()),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: AppColor.cardDark,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${NumberFormat.currency(symbol: '', decimalDigits: 6, locale: "en_US").format(0.000193)} ETH",
                            style: AppFont.medium14
                                .copyWith(color: AppColor.textDark),
                          ),
                          Text(
                            "\$${NumberFormat.currency(symbol: '', decimalDigits: 2, locale: "en_US").format(0.092)}",
                            style: AppFont.reguler12.copyWith(
                              color: AppColor.grayColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.0.width,
                    Text(
                      "3.00 GWEI",
                      style:
                          AppFont.reguler12.copyWith(color: AppColor.grayColor),
                    ),
                    8.0.width,
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColor.grayColor,
                      size: 16.h,
                    )
                  ],
                ),
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
            "Transfer",
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
      bottomNavigationBar: PrimaryButton(
        title: "Continue",
        onPressed: () {},
        margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
      ),
    );
  }
}
