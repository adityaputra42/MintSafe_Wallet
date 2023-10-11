import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/utils/helper/method_helper.dart';
import 'package:mintsafe_wallet/view/pages/Home_page/component/nft_list.dart';
import 'package:mintsafe_wallet/view/pages/Home_page/component/token_list.dart';
import 'package:mintsafe_wallet/view/pages/change_network.dart/change_network.dart';
import 'package:mintsafe_wallet/view/pages/change_wallet/change_wallet.dart';
import 'package:mintsafe_wallet/view/pages/receive_token/receive_token.dart';
import 'package:mintsafe_wallet/view/pages/scan/scann_page.dart';
import 'package:mintsafe_wallet/view/pages/select_token/select_token.dart';
import 'package:mintsafe_wallet/view/widget/card_action.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../config/config.dart';
import '../../../domain/controller/controller.dart';
import '../../../domain/controller/evm_new_controller.dart';

class HomePage extends StatelessWidget {
  final EvmNewController evm;
  HomePage({super.key, required this.evm});
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Widget cardWallet() {
      return Container(
        width: double.infinity,
        height: 210.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            gradient: LinearGradient(colors: [
              Color(int.parse(evm.networkController.selectedChain.value.color ?? "")),
              AppColor.cardDark
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 0.5, spreadRadius: 0.5, color: Colors.black12)
            ],
            image: const DecorationImage(
                image: AssetImage(AppImage.masking), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 48.h,
                    height: 48.h,
                    child: ClipPolygon(
                      sides: 6,
                      rotate: 0,
                      child: Container(
                          padding: EdgeInsets.all(1.h),
                          color: Colors.transparent,
                          child: Image.asset(
                              evm.networkController.selectedChain.value.logo ??
                                  AppImage.eth)),
                    ),
                  ),
                  8.0.height,
                  Text(
                      "${evm.selectedAddress.value.balance ?? 0} ${evm.networkController.selectedChain.value.symbol ?? ''}",
                      style: AppFont.semibold24.copyWith(
                        color: AppColor.textDark,
                      )),
                  2.0.height,
                  Text("~\$ 0.0",
                      style: AppFont.medium16.copyWith(
                        color: AppColor.textDark,
                      )),
                ],
              ),
            ),
            CardAction(
              // color: Colors.white.withOpacity(0.8),
              scan: () {
                Get.to(() => const ScannPage());
              },
              receive: () {
                Get.to(() => const ReceiveTokenPage());
              },
              transfer: () {
                Get.to(() => const SelectTokenPage());
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                width: ScreenUtil().screenWidth,
                child: Image.asset(
                  AppImage.maskHome,
                  fit: BoxFit.cover,
                )),
            Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Skeletonizer(
                  enabled:  evm.isLoadingNetwork.value,
                  effect: const ShimmerEffect(
                      baseColor: AppColor.grayColor,
                      // highlightColor: AppColor.grayColor,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight),
                  child: Column(
                    children: [
                      24.0.height,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ChangeWallet());
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 48.w,
                              height: 48.w,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 48.w,
                                    height: 48.w,
                                    padding: EdgeInsets.all(2.h),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2.h,
                                            color: AppColor.primaryColor)),
                                    child: Blockies(
                                        size: 0.55,
                                        data:
                                            evm.selectedAddress.value.address ??
                                                "-",
                                        shape: BlockiesShape.circle),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 16.w,
                                      height: 16.w,
                                      padding: EdgeInsets.all(2.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: AppColor.secondaryColor),
                                      child: Image.asset(AppIcon.chnageIcon),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            12.0.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hi, Welcome Back",
                                    style: AppFont.reguler12
                                        .copyWith(color: AppColor.grayColor),
                                  ),
                                  Text(
                                    MethodHelper().shortAddress(
                                        address:
                                            evm.selectedAddress.value.address ??
                                                ''),
                                    style: AppFont.medium14
                                        .copyWith(color: AppColor.textDark),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => ChangeNetwork());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.r),
                                    color: AppColor.cardDark),
                                child: Row(
                                  children: [
                                    Text(
                                        "${evm.networkController.selectedChain.value.name}",
                                        style: AppFont.medium14.copyWith(
                                            color: AppColor.primaryColor)),
                                    4.0.width,
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.primaryColor,
                                      size: 14.w,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      24.0.height,
                      cardWallet(),
                      16.0.height,
                      Expanded(
                        child: Obx(() {
                          return DefaultTabController(
                            length: 2,
                            initialIndex: controller.tabIndex.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 60.h,
                                  padding: EdgeInsets.all(4.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: AppColor.cardDark,
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 0.5,
                                          spreadRadius: 0.5,
                                          color: Colors.black12)
                                    ],
                                  ),
                                  child: TabBar(
                                    // automaticIndicatorColorAdjustment: false,
                                    indicator: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    isScrollable: false,
                                    dividerColor: AppColor.cardDark,
                                    indicatorColor: AppColor.cardDark,
                                    labelColor: AppColor.textDark,
                                    labelPadding: EdgeInsets.zero,
                                    labelStyle: AppFont.semibold16,
                                    unselectedLabelColor: AppColor.grayColor,
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
                                    ? TokenList()
                                    : const NftList()
                                // TabBarView(children: [Wall()])
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
