import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../domain/controller/security_privacy_controller.dart';

class ActivePrivateKey extends StatelessWidget {
  ActivePrivateKey({super.key});

  final SecurityPrivasyController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: WidgetHelper.appBar(
          context: context,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.inactiveStatePrivateKey();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: 24.h,
                ),
              ),
              16.0.width,
              Text("Private Key",
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor)),
            ],
          )),
      body: Stack(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            child: Image.asset(
              AppImage.maskHome,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.0.height,
                  Container(
                    width: double.infinity,
                    height: 60.h,
                    padding: EdgeInsets.all(4.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Theme.of(context).cardColor,
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 0.5,
                              blurRadius: 0.5,
                              color: Colors.black12)
                        ]),
                    child: TabBar(
                      // automaticIndicatorColorAdjustment: false,
                      indicator: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      isScrollable: false,
                      dividerColor: Theme.of(context).cardColor,
                      indicatorColor: Theme.of(context).cardColor,
                      labelColor: AppColor.textDark,
                      labelPadding: EdgeInsets.zero,
                      labelStyle: AppFont.semibold16,
                      unselectedLabelColor: AppColor.grayColor,
                      unselectedLabelStyle: AppFont.medium16,
                      indicatorSize: TabBarIndicatorSize.tab,
                      onTap: (index) {},
                      tabs: const [
                        Tab(
                          child: Text(
                            "Text",
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Qr Code",
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.0.height,
                  const Warning(
                    warning:
                        'This is the private key for “Main Wallet”. Never disclose this key, anyone who have your private key can fully control your account. Beware of any scam and fraud.',
                  ),
                  24.0.height,
                  Expanded(
                      child: TabBarView(children: [
                    textPrivateKey(context),
                    qrCodePrivatekey(context)
                  ]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column qrCodePrivatekey(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: ScreenUtil().screenWidth - 48.w,
          padding: EdgeInsets.all(42.w),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(12.r),
              color: Theme.of(context).cardColor),
          child: Container(
            padding: EdgeInsets.all(32.h),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(12.r),
                color: AppColor.primaryColor.withOpacity(0.25)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColor.cardLight),
              child: Center(
                child: QrImageView(
                  data: controller.privateKeySelected.value,
                  version: QrVersions.auto,
                  gapless: false,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column textPrivateKey(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Theme.of(context).cardColor,
              border: Border.all(width: 1.h, color: AppColor.primaryColor)),
          child: Text(
            controller.privateKeySelected.value,
            style: AppFont.medium14
                .copyWith(color: Theme.of(context).indicatorColor),
          ),
        ),
        const Spacer(),
        SecondaryButton(
          title: "Copy Pharse",
          onPressed: () {
            MethodHelper()
                .handleCopy(data: controller.privateKeySelected.value);
          },
          margin: EdgeInsets.only(bottom: 36.h, top: 8.h),
        ),
      ],
    );
  }
}
