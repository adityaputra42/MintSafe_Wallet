
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/home_controller.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/view/pages/Home_page/component/nft_list.dart';
import 'package:mintsafe_wallet/view/pages/Home_page/component/token_list.dart';
import 'package:mintsafe_wallet/view/pages/scan/scann_page.dart';
import 'package:mintsafe_wallet/view/pages/select_token.dart/select_token.dart';
import 'package:mintsafe_wallet/view/widget/card_action.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Widget cardWallet() {
      return Container(
        width: double.infinity,
        height: 210.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColor.primaryColor,
            image: const DecorationImage(
                image: AssetImage(AppImage.masking), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            children: [
              16.0.height,
              Text("~\$123.673",
                  style: AppFont.semibold24.copyWith(
                    color: AppColor.white,
                  )),
              8.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("0xfhas7gjkd....ashajk3q9c",
                      style: AppFont.medium14.copyWith(
                        color: AppColor.white,
                      )),
                  8.0.width,
                  Icon(
                    Icons.copy,
                    size: 18.h,
                    color: AppColor.greenBuy,
                  )
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: CardAction(
                  scan: () {
                    Get.to(() => const ScannPage());
                  },
                  receive: () {
                    Get.to(() => const SelectTokenPage());
                  },
                  transfer: () {
                    Get.to(() => const SelectTokenPage());
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            24.0.height,
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2.h, color: AppColor.primaryColor)),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor,
                    ),
                    child: Image.asset(
                      AppImage.avatar,
                    ),
                  ),
                ),
                8.0.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, Welcome Back",
                        style: AppFont.reguler12,
                      ),
                      Text(
                        "Dompet Saya",
                        style: AppFont.medium14,
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColor.secondaryColor.withOpacity(0.25)),
                  child: Row(
                    children: [
                      Text("Ethereum Mainet",
                          style: AppFont.medium12
                              .copyWith(color: AppColor.primaryColor)),
                      4.0.width,
                      Icon(
                        Icons.expand_more_rounded,
                        color: AppColor.primaryColor,
                        size: 24.w,
                      ),
                    ],
                  ),
                )
              ],
            ),
            24.0.height,
            cardWallet(),
            16.0.height,
            Expanded(
              child: Obx(() {
                return DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 60.h,
                        padding: EdgeInsets.all(4.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  color: Colors.white12)
                            ]),
                        child: TabBar(
                          // automaticIndicatorColorAdjustment: false,
                          indicator: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(12.r)),
                          isScrollable: false,
                          dividerColor: Colors.white,
                          indicatorColor: AppColor.white,
                          labelColor: AppColor.white,
                          labelPadding: EdgeInsets.zero,
                          labelStyle: AppFont.semibold16,
                          unselectedLabelColor: AppColor.darkerGray,
                          unselectedLabelStyle: AppFont.medium16,
                          indicatorSize: TabBarIndicatorSize.tab,
                          onTap: (index) {
                            controller.onChangeTabIndex(index);
                          },
                          tabs: const [
                            Tab(
                              child: Text(
                                "Token",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "NFT",
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.0.height,
                      controller.tabIndex.value == 0
                          ? const TokenList()
                          : const NftList()
                      // TabBarView(children: [Wall()])
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      )),
    );
  }
}
