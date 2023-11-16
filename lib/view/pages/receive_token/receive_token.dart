import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../widget/widget.dart';

class ReceiveTokenPage extends StatelessWidget {
  ReceiveTokenPage({super.key, this.token});
  final EvmNewController evm = Get.find();
  final SelectedToken? token;
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
                    child: Image.asset(token == null
                        ? evm.selectedChain.value.logo!
                        : token!.logo!)),
              ),
            ),
            8.0.height,
            Text(
              evm.selectedChain.value.name ?? '',
              style: AppFont.medium16
                  .copyWith(color: Theme.of(context).indicatorColor),
            ),
            16.0.height,
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
                  color: Theme.of(context).cardColor),
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
                        data: evm.selectedAddress.value.address ?? '',
                        version: QrVersions.auto,
                        size: 240.h,
                        gapless: false,
                      ),
                    ),
                  ),
                  32.0.height,
                  Text(
                    MethodHelper().shortAddress(
                        address: evm.selectedAddress.value.address ?? "",
                        length: 12),
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

    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: WidgetHelper.appBar(context: context,
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
            Text(
              "Receive ${token?.id == null ? (evm.selectedChain.value.symbol ?? '') : (token?.symbol ?? "")}",
              style: AppFont.medium16.copyWith(color: Theme.of(context).indicatorColor),
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
              color: Theme.of(context).cardColor,
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
                onPressed: () {
                  MethodHelper().handleCopy(
                      data: evm.selectedAddress.value.address ?? '');
                },
              ),
              SecondaryButton(
                width: MediaQuery.of(context).size.width * 0.43,
                title: "Share",
                icon: Icon(
                  Icons.share,
                  size: 24.h,
                  color: AppColor.primaryColor,
                ),
                onPressed: () {
                  Share.share(evm.selectedAddress.value.address ?? '');
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
