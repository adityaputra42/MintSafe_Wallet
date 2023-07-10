import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/domain/controller/transfer_controller.dart';
import 'package:mintsafe_wallet/view/pages/transfer/components/set_gas_fee/components/advance_setting.dart';
import 'package:mintsafe_wallet/view/pages/transfer/components/set_gas_fee/components/select_gas_fee.dart';

import '../../../../../utils/utils.dart';
import '../../../../widget/widget.dart';

class SetGasFee extends StatelessWidget {
  SetGasFee({super.key});
  final Transfercontroller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.0.height,
                Container(
                  width: double.infinity,
                  height: 60.h,
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColor.cardDark,
                      boxShadow: [
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
                    indicatorColor: AppColor.cardDark,
                    dividerColor: AppColor.cardDark,
                    labelColor: AppColor.textDark,
                    labelPadding: EdgeInsets.zero,
                    labelStyle:
                        AppFont.semibold16.copyWith(color: AppColor.textDark),
                    unselectedLabelColor: AppColor.grayColor,
                    unselectedLabelStyle: AppFont.medium16,
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) {
                      controller.changeTab(index);
                    },
                    tabs: const [
                      Tab(
                        child: Text(
                          "Select Gas Fee",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Advance Setting",
                        ),
                      ),
                    ],
                  ),
                ),
                16.0.height,
                controller.selectedTab.value == 0
                    ? const SelectGasFee()
                    : const AdvanceSetting()
                // // TabBarView(children: [Wall()])
              ],
            ),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Set Gas Fee",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: body(),
      bottomNavigationBar: PrimaryButton(
        title: "Continue",
        activeColor: AppColor.primaryColor,
        onPressed: () {},
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      ),
    );
  }
}
