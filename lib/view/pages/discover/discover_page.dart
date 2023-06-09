import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget newsFirst() {
      return Container(
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: const DecorationImage(
                image: AssetImage(AppImage.bnbnews), fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            height: 60.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColor.blackText.withOpacity(0.1),
                AppColor.blackText.withOpacity(0.6),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(16.r), top: Radius.circular(4.r)),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "BNB Naik Drastis kapan ya",
                style: AppFont.medium16.copyWith(color: AppColor.white),
                maxLines: 1,
              ),
              Text(
                DateFormat("MMM dd, yyyy").format(DateTime.now()),
                style: AppFont.reguler12.copyWith(color: AppColor.white),
              )
            ]),
          ),
        ),
      );
    }

    Widget cardNews() {
      return Row(
        children: [
          Container(
            height: 100.h,
            width: 140.w,
            margin: EdgeInsets.only(right: 16.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: const DecorationImage(
                    image: AssetImage(AppImage.bnbnews), fit: BoxFit.cover)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BNB Naik Drastis",
                  style: AppFont.medium16,
                  maxLines: 1,
                ),
                Text(
                  "Lorem ipsum dolor sit, amet consectetur askadi pisicing elit. Aut labore,amet consectetur askadi pisicing elit. Aut labore",
                  style: AppFont.reguler14.copyWith(color: AppColor.darkerGray),
                  maxLines: 3,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  DateFormat("MMM dd, yyyy").format(DateTime.now()),
                  style: AppFont.reguler14.copyWith(color: AppColor.darkerGray),
                  maxLines: 1,
                )
              ],
            ),
          )
        ],
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      appBar: WidgetHelper.appBar(
          title: Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: Text(
          "Discover",
          style: AppFont.semibold20,
        ),
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView(
          children: [
            newsFirst(),

            16.0.height,
            Column(
              children: [
                cardNews(),
                8.0.height,
                cardNews(),
                8.0.height,
                cardNews(),
                8.0.height,
                cardNews(),
                8.0.height,
                cardNews(),
                8.0.height,
                cardNews(),
                8.0.height,
              ],
            )
            // ListView.builder(
            //   itemBuilder: (context, index) => Padding(
            //     padding: EdgeInsets.only(bottom: 8.h),
            //     child: cardNews(),
            //   ),
            //   itemCount: 5,
            // ),
          ],
        ),
      ),
    );
  }
}
