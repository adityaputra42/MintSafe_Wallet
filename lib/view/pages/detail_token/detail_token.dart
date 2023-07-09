import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/domain/controller/detail_token_controller.dart';
import 'package:mintsafe_wallet/view/pages/detail_token/component/activity.dart';
import 'package:mintsafe_wallet/view/pages/detail_token/component/info_token.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';

class DetailToken extends StatelessWidget {
  DetailToken({super.key});
  final DetailTokenController controller = Get.put(DetailTokenController());
  @override
  Widget build(BuildContext context) {
    Widget cardWallet() {
      return Container(
        width: double.infinity,
        height: 200.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: AppColor.primaryColor.withOpacity(0.15))
            ],
            color: AppColor.primaryColor,
            image: const DecorationImage(
                image: AssetImage(AppImage.masking), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 48.h,
                height: 48.h,
                child: ClipPolygon(
                  boxShadows: [
                    PolygonBoxShadow(
                        color: AppColor.primaryColor.withOpacity(0.2),
                        elevation: 1)
                  ],
                  sides: 6,
                  rotate: 0,
                  child: Container(
                      padding: EdgeInsets.all(1.h),
                      color: Colors.transparent,
                      child: Image.asset(AppImage.eth)),
                ),
              ),
              8.0.height,
              Text(
                "${NumberFormat.currency(symbol: '', decimalDigits: 4, locale: "en_US").format(0)} ETH",
                style: AppFont.semibold24.copyWith(
                  color: AppColor.textDark,
                ),
              ),
              Text(
                  "~\$${NumberFormat.currency(symbol: '', decimalDigits: 2, locale: "en_US").format(0)}",
                  style: AppFont.reguler16.copyWith(
                    color: AppColor.textDark,
                  )),
              4.0.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("0xfhas7gjkd....ashajk3q9c",
                      style: AppFont.medium14.copyWith(
                        color: AppColor.textDark,
                      )),
                  8.0.width,
                  Icon(
                    Icons.copy,
                    size: 18.h,
                    color: AppColor.textDark,
                  )
                ],
              ),
            ],
          ),
        ),
      );
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
            "Ethereum Mainet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            16.0.height,
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
                        padding: EdgeInsets.all(5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppColor.cardDark,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  color:
                                      AppColor.primaryColor.withOpacity(0.15))
                            ]),
                        child: TabBar(
                          // automaticIndicatorColorAdjustment: false,
                          indicator: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
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
                                "Activity",
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Info",
                              ),
                            ),
                          ],
                        ),
                      ),
                      16.0.height,
                      controller.tabIndex.value == 0
                          ? const Activity()
                          : const InfoToken()
                      // TabBarView(children: [Wall()])
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: AppColor.cardDark,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: AppColor.primaryColor.withOpacity(0.25))
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PrimaryButton(
              title: "Send",
              activeColor: AppColor.yellowColor,
              onPressed: () {},
              width: MediaQuery.of(context).size.width * 0.43,
            ),
            PrimaryButton(
              title: "Receive",
              activeColor: AppColor.primaryColor,
              onPressed: () {},
              width: MediaQuery.of(context).size.width * 0.43,
            ),
          ],
        ),
      ),
    );
  }
}
