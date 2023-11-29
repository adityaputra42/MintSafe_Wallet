import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../widget/widget.dart';

class AlertSwitchNetwork extends StatelessWidget {
  AlertSwitchNetwork({
    super.key,
    required this.data,
  });
  final Map<String, dynamic> data;
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Row(
            children: [
              24.0.width,
              Expanded(
                child: Text(
                  "Switch Network",
                  style: AppFont.medium16.copyWith(
                    color: Theme.of(context).indicatorColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).indicatorColor,
                  size: 24.w,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return SizedBox(
        width: 900.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColor.primaryColor.withOpacity(0.1)),
              child: Center(
                child: Text(
                  "Allow this site to switch network?",
                  style: AppFont.medium14
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
              ),
            ),
            16.0.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    evm.selectedChain.value.name ?? "",
                    style: AppFont.medium14.copyWith(
                      color: AppColor.grayColor,
                    ),
                  ),
                ),
                const Expanded(
                  child: CircleAvatar(
                      backgroundColor: AppColor.primaryColor,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  child: Text(
                    data['object']['chainName'],
                    style: AppFont.medium14.copyWith(
                      color: AppColor.grayColor,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            32.0.height,
            PrimaryButton(
              onPressed: () async {
                evm.changeNetwork(
                  evm.listChainSelected.singleWhere((element) =>
                      element.chainId ==
                      int.parse(
                              data['object']['chainId'].toString().substring(2),
                              radix: 16)
                          .toString()),
                );
              },
              title: 'Switch',
              height: 48,
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      titlePadding: EdgeInsets.zero,
      title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
