import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/domain/controller/detail_token_controller.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/card_activity.dart';
import '../receive_token/receive_token.dart';
import '../scan/scann_page.dart';
import '../transfer/choose_receiver.dart';

class DetailToken extends StatelessWidget {
  DetailToken({super.key, required this.token});
  final SelectedToken token;
  final DetailTokenController controller = Get.put(DetailTokenController());
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardWallet() {
      return Container(
        width: double.infinity,
        height: 210.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: LinearGradient(colors: [
              Color(int.parse(evm.selectedChain.value.color ?? "0xff1AA9A4")),
              AppColor.cardDark
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 0.5, spreadRadius: 0.5, color: Colors.black12)
            ],
            image: const DecorationImage(
                image: AssetImage(AppImage.masking), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                          child: Image.asset(token.logo ?? AppImage.eth)),
                    ),
                  ),
                  8.0.height,
                  Text("${token.balance ?? 0} ${token.symbol ?? ''}",
                      style: AppFont.semibold24.copyWith(
                        color: AppColor.textDark,
                      )),
                  Text("~\$ 0.0",
                      style: AppFont.medium16.copyWith(
                        color: AppColor.textDark,
                      )),
                ],
              ),
            ),
            CardAction(
              scan: () {
                Get.to(() => ScannPage(
                      scanType: ScanType.address,
                      asset: AssetType.token,
                      token: token,
                    ));
              },
              receive: () {
                Get.to(() => ReceiveTokenPage());
              },
              transfer: () {
                Get.to(() => ChooseReceiver(
                      assetType: AssetType.token,
                      token: token,
                    ));
              },
            ),
          ],
        ),
      );
    }

    return Obx(() {
      final listActivity = evm.listActivity
          .where(
            (e) =>
                e.contractAddress!.toLowerCase() ==
                token.contractAddress!.toLowerCase(),
          )
          .toList();
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
                  "${token.name}",
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.0.height,
                  cardWallet(),
                  16.0.height,
                  Text(
                    "Activity Token",
                    style: AppFont.semibold16
                        .copyWith(color: Theme.of(context).indicatorColor),
                  ),
                  16.0.height,
                  Expanded(
                    child: evm.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : listActivity.isEmpty
                            ? const Center(
                                child: Empty(title: "No Transaction yet!"))
                            : ListView.builder(
                                itemCount: listActivity.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: CardActivity(
                                      activity: listActivity[index],
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
