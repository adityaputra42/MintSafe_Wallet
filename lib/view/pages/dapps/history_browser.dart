import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/widget/empty.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../domain/controller/browser_controller.dart';
import '../../../utils/utils.dart';
import 'new_dapps.dart';

class HistoryBrowser extends StatelessWidget {
  HistoryBrowser({super.key});

  final BrowserController browserController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                "History Browser",
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
          Obx(() {
            return browserController.dappsHistory.isEmpty
                ? const Empty(title: "No Browser History")
                : ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                    itemCount: browserController.dappsHistory.length,
                    itemBuilder: (c, i) => GestureDetector(
                          onTap: () {
                            Get.to(() => DappsWeb3(
                                  initialUrl: browserController
                                      .dappsHistory.reversed
                                      .toList()[i]
                                      .url!,
                                ));
                          },
                          child: cardHitoryBrowser(
                              browserController.dappsHistory.reversed
                                  .toList()[i],
                              c),
                        ));
          })
        ],
      ),
    );
  }

  Padding cardHitoryBrowser(DappsHistory item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            Icons.public,
            size: 32.w,
          ),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? "",
                  maxLines: 1,
                  style: AppFont.medium14
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                Text(
                  item.url ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.light12.copyWith(color: AppColor.grayColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              browserController.deleteDappsHistory(item.id!);
            },
            child: Icon(
              Icons.delete,
              color: AppColor.redColor,
              size: 20.w,
            ),
          )
        ],
      ),
    );
  }
}
