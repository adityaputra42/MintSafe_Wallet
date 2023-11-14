import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/chain_network/list_chain_selected.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/view/pages/add_network/add_network.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class ChangeNetwork extends StatelessWidget {
  ChangeNetwork({super.key});
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardNetwork(
        {required ListChainSelected chain, bool isSelected = false}) {
      return GestureDetector(
        onTap: () {
          evm.changeNetwork(chain);
        },
        child: Row(
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
                    child: Image.asset(chain.logo ?? AppImage.eth)),
              ),
            ),
            16.0.width,
            Expanded(
                child: Text(
              chain.name ?? '',
              style: AppFont.medium16.copyWith(color: AppColor.textDark),
            )),
            16.0.width,
            isSelected
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
        child: Obx(() {
          return Column(
            children: [
              16.0.height,
              const SearchField(),
              16.0.height,
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: cardNetwork(
                    chain: evm.listChainSelected[index],
                    isSelected: evm.listChainSelected[index].chainId ==
                        evm.selectedChain.value.chainId,
                  ),
                ),
                itemCount: evm.listChainSelected.length,
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
          );
        }),
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
