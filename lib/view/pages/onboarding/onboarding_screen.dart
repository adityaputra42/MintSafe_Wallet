import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/onboarding_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:mintsafe_wallet/view/widget/secondary_button.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Image.asset(
            AppImage.maskOnboarding,
            fit: BoxFit.cover,
          ),
        ),
        Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "MintSafe",
                style: AppFont.semibold24.copyWith(color: AppColor.textDark),
              ),
              48.0.height,
              Image.asset(
                controller.selectedIndex.value == 0
                    ? AppImage.ilustrasi1
                    : controller.selectedIndex.value == 1
                        ? AppImage.ilustrasi2
                        : AppImage.ilustrasi3,
                width: 382.w,
              ),
              40.0.height,
              stepIndicator(
                  listData: [1, 2, 3],
                  selectedIndex: controller.selectedIndex.value),
              16.0.height,
              Container(
                padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 36.w),
                width: double.infinity,
                height: 320.h,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.w),
                        topRight: Radius.circular(24.w))),
                child: Column(
                  children: [
                    Text(
                      controller.selectedIndex.value == 0
                          ? "Secure"
                          : controller.selectedIndex.value == 1
                              ? "Protect"
                              : "Trusted",
                      style: AppFont.semibold24
                          .copyWith(color: Theme.of(context).indicatorColor),
                    ),
                    8.0.height,
                    Text(
                      controller.selectedIndex.value == 0
                          ? "Protecting Your Digital Fortune, One Wallet at a Time."
                          : controller.selectedIndex.value == 1
                              ? "Where Your Assets Thrive, Protected with Precision."
                              : "Crypto Wallet Trusted\nYour Gateway to Financial Confidence",
                      style:
                          AppFont.reguler16.copyWith(color: AppColor.grayColor),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    PrimaryButton(
                        title: "Continue",
                        onPressed: () {
                          controller.changeIndex();
                        }),
                    16.0.height,
                    controller.selectedIndex.value == 2
                        ? SizedBox(
                            height: 0.h,
                          )
                        : SecondaryButton(
                            title: "Skip",
                            onPressed: () {
                              PrefHelper.instance.setFirstInstall();
                              Get.to(() => const GetStartedPage());
                              controller.selectedIndex.value = 0;
                            })
                  ],
                ),
              )
            ],
          );
        })
      ]),
    );
  }

  Row stepIndicator({int? selectedIndex, required List<dynamic> listData}) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: listData
            .map(
              (e) => Container(
                margin: EdgeInsets.only(
                    right: listData.indexOf(e) == listData.last ? 0 : 12.w),
                width: listData.indexOf(e) == selectedIndex ? 36.w : 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: listData.indexOf(e) == selectedIndex
                        ? AppColor.primaryColor
                        : AppColor.secondaryColor),
              ),
            )
            .toList());
  }
}
