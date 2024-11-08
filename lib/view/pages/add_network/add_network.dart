import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/add_network_controller.dart';
import 'package:mintsafe_wallet/view/pages/add_network/component/custom_network.dart';
import 'package:mintsafe_wallet/view/pages/add_network/component/search_network.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';

class AddNetworkPage extends StatelessWidget {
  AddNetworkPage({super.key});
  final AddNetworkController controller = Get.put(AddNetworkController());

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: DefaultTabController(
            length: 2,
            initialIndex: controller.selectedTab.value,
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
                            spreadRadius: 1,
                            blurRadius: 1,
                            color: Colors.black12)
                      ]),
                  child: TabBar(
                    // automaticIndicatorColorAdjustment: false,
                    indicator: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    isScrollable: false,
                    indicatorColor: Theme.of(context).cardColor,
                    dividerColor: Theme.of(context).cardColor,
                    labelColor: AppColor.textDark,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: AppFont.semibold16
                        .copyWith(color: Theme.of(context).indicatorColor),
                    unselectedLabelColor: AppColor.grayColor,
                    unselectedLabelStyle: AppFont.medium16,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) {
                      controller.changeTab(index);
                    },
                    tabs: const [
                      Tab(
                        child: Text(
                          "Search Network",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Custom Network",
                        ),
                      ),
                    ],
                  ),
                ),
                16.0.height,
                controller.selectedTab.value == 0
                    ? SearchNetwork(
                        controller: controller,
                      )
                    : CustomNetwork(
                        controller: controller,
                      )
                // TabBarView(children: [Wall()])
              ],
            ),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: WidgetHelper.appBar(
          context: context,
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
                "Add Network",
                style: AppFont.medium16
                    .copyWith(color: Theme.of(context).indicatorColor),
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
            ),
          ),
          body(),
        ],
      ),
    );
  }
}
