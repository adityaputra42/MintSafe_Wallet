import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../domain/controller/security_privacy_controller.dart';
import '../../../widget/widget.dart';

class ActivePhrase extends StatelessWidget {
  ActivePhrase({super.key});
  final SecurityPrivasyController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: WidgetHelper.appBar(
          context: context,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.inactiveStateSheedPharse();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: 24.h,
                ),
              ),
              16.0.width,
              Text("Recovery Pharse",
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
                        'This is your recovery phrase. Write it down on a paper and keep it in a safe place. You\'ll be asked to re-enter this phrase (in order) on the next step.',
                  ),
                  24.0.height,
                  Expanded(
                    child: TabBarView(children: [
                      textMnemonic(context),
                      qrCodeMnemonic(context),
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column qrCodeMnemonic(BuildContext context) {
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
                  data: controller.mnemonicSelected.value,
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

  Column textMnemonic(BuildContext context) {
    return Column(
      children: [
        Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 16.h,
            runSpacing: 8.h,
            direction: Axis.horizontal,
            children: controller.mnemonicMap
                .map(
                  (e) => cardPniomoni(
                      number: e['id'], text: e['data'], context: context),
                )
                .toList()),
        const Spacer(),
        SecondaryButton(
          title: "Copy Pharse",
          onPressed: () {
            MethodHelper().handleCopy(data: controller.mnemonicSelected.value);
          },
          margin: EdgeInsets.only(bottom: 36.h, top: 8.h),
        ),
      ],
    );
  }

  Widget cardPniomoni(
      {required int number,
      required String text,
      required BuildContext context}) {
    return Container(
      height: 42.h,
      width: MediaQuery.of(context).size.width * 0.425,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 0.1,
                spreadRadius: 0.1,
                color: AppColor.grayColor.withOpacity(0.25))
          ],
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).cardColor),
      child: Text("$number. $text",
          style: AppFont.medium14.copyWith(
            color: Theme.of(context).indicatorColor,
          )),
    );
  }
}
