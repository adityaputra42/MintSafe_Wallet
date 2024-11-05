import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/view/pages/setting/network/edit_network.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../utils/utils.dart';
import '../../../widget/widget.dart';

class NetworkSetting extends StatelessWidget {
  NetworkSetting({super.key});
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
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
              Text("Network Setting",
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor)),
            ],
          )),
      body: Stack(children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          child: Image.asset(
            AppImage.maskHome,
            fit: BoxFit.cover,
          ),
        ),
        Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                24.0.height,
                SearchField(
                  onChange: (key) => evm.searchChainNetwork(key),
                ),
                16.0.height,
                Expanded(
                    child: evm.searchChain.isEmpty
                        ? const Empty(title: "Chain Not Found")
                        : ListView.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child:
                                  cardNetwork(context, evm.searchChain[index]),
                            ),
                            itemCount: evm.searchChain.length,
                          ))
              ],
            ),
          );
        })
      ]),
    );
  }

  Widget cardNetwork(BuildContext context, ChainNetwork network) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            onPressed: (context) {},
            autoClose: true,
            backgroundColor: AppColor.redColor,
            foregroundColor: AppColor.textDark,
            icon: Icons.delete_outline_rounded,
            // label: 'Delete',
            borderRadius: BorderRadius.circular(8.r),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(() => EditNetwork(chain: network));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48.h,
                height: 48.h,
                child: ClipPolygon(
                  sides: 6,
                  rotate: 0,
                  child: Container(
                      padding: EdgeInsets.all(1.h),
                      color: Colors.transparent,
                      child: Image.asset(network.logo!)),
                ),
              ),
              8.0.width,
              Expanded(
                child: Text(
                  network.name ?? "",
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              8.0.width,
              Text(
                network.symbol ?? '',
                style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
              ),
              // 4.0.width,
              // Icon(
              //   Icons.arrow_forward_ios_rounded,
              //   size: 20.w,
              //   color: Theme.of(context).indicatorColor,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
