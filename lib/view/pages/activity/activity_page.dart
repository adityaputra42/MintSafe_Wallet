import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/card_activity.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../config/config.dart';
import '../../../data/src/app_image.dart';
import '../../../domain/controller/activity_tx_controller.dart';

class ActivityPage extends StatelessWidget {
  ActivityPage({super.key});
  final ActivityTxController controller =
      Get.isRegistered() ? Get.find() : Get.put(ActivityTxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                width: ScreenUtil().screenWidth,
                child: Image.asset(
                  AppImage.maskHome,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.0.height,
                  Text(
                    "Activity",
                    style:
                        AppFont.semibold20.copyWith(color: AppColor.textDark),
                  ),
                  24.0.height,
                  Expanded(
                    child: Obx(() {
                      return DefaultTabController(
                        length: 2,
                        initialIndex: controller.selectedTabActivity.value,
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
                                    borderRadius: BorderRadius.circular(8.r)),
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
                                  controller.changeActivity(index);
                                },
                                tabs: const [
                                  Tab(
                                    child: Text(
                                      "Coin",
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      "Token",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            16.0.height,
                            controller.selectedTabActivity.value == 0
                                ? listActivityCoin()
                                : listActivityToken()
                            // TabBarView(children: [Wall()])
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listActivityCoin() {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: const CardActivity(
          title: "Transfer",
        ),
      ),
      itemCount: 5,
    ));
  }

  Widget listActivityToken() {
    return const Expanded(
        child: Center(
      child: Empty(title: "No transaction yet?"),
    ));
  }
}
