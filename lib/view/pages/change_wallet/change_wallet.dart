import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/view/pages/add_wallet/add_wallet.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../utils/utils.dart';
import '../../widget/widget.dart';

class ChangeWallet extends StatelessWidget {
  ChangeWallet({super.key});
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardAccount({required Address address}) {
      return GestureDetector(
        onTap: () {
          if (address.address != evm.selectedAddress.value.address) {
            evm.changeAddress(address);
          }
        },
        child: 
        // Container(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 16.w,
        //     vertical: 12.w,
        //   ),
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12.r),
        //       color: Theme.of(context).cardColor,
        //       boxShadow: [BoxShadow(spreadRadius: 0.5.h,blurRadius: 0.3,color: Colors.black12)],
        //       border: Border.all(
        //           width: 1.w,
        //           color: address.address == evm.selectedAddress.value.address
        //               ? AppColor.primaryColor
        //               : Colors.transparent)),
        //   child: 
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 2.h, color: AppColor.primaryColor)),
                child: Blockies(
                    size: 0.55,
                    data: address.address ?? "-",
                    shape: BlockiesShape.circle),
              ),
              8.0.width,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${address.name} ${address.id}",
                    style: AppFont.medium14.copyWith(color: Theme.of(context).indicatorColor,),
                  ),
                  4.0.height,
                  Text(
                    MethodHelper().shortAddress(
                        address: address.address ?? "", length: 8),
                    style: AppFont.medium12.copyWith(color: AppColor.grayColor,),
                  )
                ],
              )),
              8.0.height,
              address.address == evm.selectedAddress.value.address
                  ? Icon(
                      Icons.check_circle_outline_rounded,
                      size: 24.w,
                      color: AppColor.primaryColor,
                    )
                  : 24.0.width
            ],
          ),
        // ),
      );
    }

    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: WidgetHelper.appBar(context: context,
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
              "Change Wallet",
              style: AppFont.medium16.copyWith(color: Theme.of(context).indicatorColor,),
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
                children: [
                  24.0.height,
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: cardAccount(address: evm.addressList[index]),
                      ),
                      itemCount: evm.addressList.length,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "want a new address?\nTap the below button to add.",
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
                          Get.to(() => const AddWallet());
                        },
                        margin: EdgeInsets.symmetric(vertical: 24.h),
                      ),
                    ],
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
