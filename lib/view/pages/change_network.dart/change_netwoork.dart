import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/pages/add_network/add_network.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class ChangeNetwork extends StatelessWidget {
  const ChangeNetwork({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardNetwork({bool isActive = false}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  blurRadius: 1,
                  color: AppColor.primaryColor.withOpacity(0.1))
            ]),
        child: Row(
          children: [
            SizedBox(
              width: 32.h,
              height: 32.h,
              child: ClipPolygon(
                sides: 6,
                rotate: 0,
                child: Container(
                    padding: EdgeInsets.all(1.h),
                    color: Colors.transparent,
                    child: Image.asset(AppImage.eth)),
              ),
            ),
            12.0.width,
            Expanded(
                child: Text(
              "Ethereum Mainet",
              style: AppFont.medium16,
            )),
            16.0.width,
            isActive
                ? Icon(
                    Icons.check_circle_outline_rounded,
                    size: 24.w,
                    color: AppColor.primaryColor,
                  )
                : const SizedBox()
          ],
        ),
      );
    }

    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(
              height: 54.h,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: AppFont.medium14,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20.w,
                    ),
                    filled: true,
                    fillColor: AppColor.white,
                    hintText: "Search",
                    hintStyle: AppFont.reguler14.copyWith(
                        fontWeight: FontWeight.w300,
                        color: AppColor.darkerGray),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide:
                          const BorderSide(color: AppColor.primaryColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w)),
              ),
            ),
            16.0.height,
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: cardNetwork(isActive: index == 1 ? true : false),
              ),
              itemCount: 10,
            ))
          ],
        ),
      );
    }

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
              "Change Network",
              style: AppFont.medium16,
            ),
          ],
        )),
        body: body(),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Couldn't find your network?\nTap the below button to add.",
              style: AppFont.reguler12.copyWith(
                color: AppColor.darkerGray,
              ),
              textAlign: TextAlign.center,
            ),
            SecondaryButton(
              title: "Add Network",
              icon: Icon(
                Icons.add_circle_outline_rounded,
                size: 24.h,
                color: AppColor.primaryColor,
              ),
              onPressed: () {
                Get.to(() => AddNetworkPage());
              },
              margin: EdgeInsets.all(24.w),
            ),
          ],
        ));
  }
}
