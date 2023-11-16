import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';
import 'package:mintsafe_wallet/view/pages/add_token/add_token.dart';
import 'package:mintsafe_wallet/view/pages/detail_token/detail_token.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

class TokenList extends StatelessWidget {
  TokenList({super.key});
  final EvmNewController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardToken(SelectedToken token) {
      return GestureDetector(
        onTap: () {
          Get.to(() => DetailToken(
                token: token,
              ));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 0.3, spreadRadius: 0.5, color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(12.r),
              color: AppColor.cardDark),
          child: Row(
            children: [
              SizedBox(
                height: 48.h,
                width: 48.h,
                child: ClipPolygon(
                  sides: 6,
                  rotate: 0,
                  child: Container(
                      padding: EdgeInsets.all(1.h),
                      color: AppColor.cardDark,
                      child: Image.asset(token.logo ?? AppImage.eth)),
                ),
              ),
              8.0.width,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          token.name ?? "",
                          style: AppFont.semibold18
                              .copyWith(color: AppColor.textDark),
                        ),
                        Text(
                          (token.balance ?? 0).toStringAsPrecision(5),
                          style: AppFont.medium16.copyWith(
                              fontFamily: "Roboto", color: AppColor.textDark),
                        )
                      ],
                    ),
                    //
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        children: [
          Obx(() {
            return Expanded(
                child: controller.tokenSelected.isEmpty
                    ? const Center(
                        child: Empty(title: "No Token List"),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 0.5.h),
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: cardToken(controller.tokenSelected[index]),
                        ),
                        itemCount: controller.tokenSelected.length,
                      ));
          }),
          SecondaryButton(
            title: "Add Token",
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 24.h,
              color: AppColor.primaryColor,
            ),
            onPressed: () {
              Get.to(() => AddTokenPage());
            },
            margin: EdgeInsets.only(bottom: 16.h),
          )
        ],
      ),
    );
  }
}
