import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/pages/add_network/add_network.dart';

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
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColor.cardDark,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.5,
                  blurRadius: 0.7,
                  color: AppColor.primaryColor.withOpacity(0.15))
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
              style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
            16.0.height,
            SizedBox(
              height: 54.h,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: AppFont.medium14.copyWith(color: AppColor.textDark),
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      size: 20.w,
                    ),
                    hintText: "Search",
                    hintStyle: AppFont.reguler14.copyWith(
                        fontWeight: FontWeight.w300, color: AppColor.grayColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                          color: AppColor.grayColor, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                          color: AppColor.grayColor, width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
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
                padding: EdgeInsets.only(bottom: 8.h),
                child: cardNetwork(isActive: index == 1 ? true : false),
              ),
              itemCount: 15,
            ))
          ],
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
              "Change Network",
              style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
                color: AppColor.grayColor,
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
