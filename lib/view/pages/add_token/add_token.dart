import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/add_token_controller.dart';
import 'package:mintsafe_wallet/view/pages/add_token/component/custom_token.dart';
import 'package:mintsafe_wallet/view/pages/add_token/component/search_token.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class AddTokenPage extends StatelessWidget {
  AddTokenPage({super.key});
  final AddTokenController controller = Get.put(AddTokenController());
  @override
  Widget build(BuildContext context) {
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
            "Add Token",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: Obx(() {
        return Padding(
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
                      controller.changeTab(index);
                    },
                    tabs: const [
                      Tab(
                        child: Text(
                          "Search Token",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Custom Token",
                        ),
                      ),
                    ],
                  ),
                ),
                16.0.height,
                controller.selectedTab.value == 0
                    ? const SearchToken()
                    : const CustomToken()
                // TabBarView(children: [Wall()])
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: PrimaryButton(
        title: "Confirm",
        onPressed: () {},
        margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 36.h),
      ),
    );
  }
}
