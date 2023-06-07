import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../data/src/src.dart';
import '../../../utils/utils.dart';

class AddNetworkPage extends StatelessWidget {
  const AddNetworkPage({super.key});

  Widget body() {
    Widget cardCoin() {
      return Row(
        children: [
          SizedBox(
            width: 36.h,
            height: 36.h,
            child: ClipPolygon(
              sides: 6,
              rotate: 0,
              child: Container(
                  padding: EdgeInsets.all(1.h),
                  color: Colors.transparent,
                  child: Image.asset(AppImage.eth)),
            ),
          ),
          8.0.width,
          Expanded(
              child: Text(
            "Ethereum Mainet",
            style: AppFont.medium16,
          )),
          16.0.width,
          Icon(
            Icons.check_circle_outline_rounded,
            size: 24.w,
            color: AppColor.darkerGray,
          )
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          16.0.height,
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
                      fontWeight: FontWeight.w300, color: AppColor.darkerGray),
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
                    borderSide: const BorderSide(color: AppColor.primaryColor),
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
              child: cardCoin(),
            ),
            itemCount: 10,
          ))
        ],
      ),
    );
  }

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
            "Add Network",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: body(),
      bottomNavigationBar: PrimaryButton(
        title: "Confirm",
        onPressed: () {},
        margin: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 36.h),
      ),
    );
  }
}
