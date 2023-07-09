import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/add_token_controller.dart';
import 'package:mintsafe_wallet/view/pages/add_token/component/custom_token.dart';
import 'package:mintsafe_wallet/view/pages/add_token/component/search_token.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class AddTokenPage extends StatelessWidget {
  AddTokenPage({super.key});
  final AddTokenController controller = Get.put(AddTokenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColor.bgLight,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textLight,
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
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white,
                      boxShadow:[
                        BoxShadow(
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: AppColor.primaryColor.withOpacity(0.15))
                      ]),
                  child: TabBar(
                    // automaticIndicatorColorAdjustment: false,
                    indicator: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    isScrollable: false,
                    dividerColor: Colors.white,
                    indicatorColor: AppColor.textDark,
                    labelColor: AppColor.textDark,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: AppFont.semibold16,
                    unselectedLabelColor: AppColor.grayColor,
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
