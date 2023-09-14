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
          16.0.width,
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
      );
    }

    Widget body() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            16.0.height,
            const SearchField(),
            16.0.height,
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: cardNetwork(isActive: index == 1 ? true : false),
              ),
              itemCount: 5,
            )),
            Column(
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
                  margin: EdgeInsets.symmetric(vertical: 24.h),
                ),
              ],
            )
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
