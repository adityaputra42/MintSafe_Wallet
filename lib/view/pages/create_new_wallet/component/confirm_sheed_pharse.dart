import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../../domain/controller/create_wallet_controller.dart';
import '../../../widget/widget.dart';

class ConfirmSheedPharse extends StatelessWidget {
ConfirmSheedPharse({
    super.key,
  });

  final CreateWalletController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Widget cardPniomoni({
      required int number,
    }) {
      return DragTarget(
        onAccept: (String value) {
          controller.setConfrimPharse(id: number, text: value);
        },
        builder: (
          context,
          accepted,
          rejected,
        ) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            height: 42.h,
            width: MediaQuery.of(context).size.width * 0.425,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 0.5.h,
                      spreadRadius: 0.5.h,
                      color: AppColor.grayColor.withOpacity(0.25))
                ],
                borderRadius: BorderRadius.circular(8.r),
                color: AppColor.cardDark),
            child: Text(
                "$number. ${(controller.confirmPharse.singleWhere((element) => element['id'] == number, orElse: () => <String, dynamic>{})['data']) ?? ''}",
                style: AppFont.medium16.copyWith(
                  color: AppColor.textDark,
                )),
          );
        },
      );
    }

    Widget cardPilihan({required String text}) {
      return Draggable(
        data: text,
        feedback: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          height: 42.h,
          width: MediaQuery.of(context).size.width * 0.258,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 0.3.h,
                    spreadRadius: 0.5.h,
                    color: AppColor.grayColor.withOpacity(0.25))
              ],
              borderRadius: BorderRadius.circular(8.r),
              color: AppColor.primaryColor),
          child: Center(
            child: Text(text,
                style: AppFont.medium16.copyWith(
                  color: AppColor.textDark,
                )),
          ),
        ),childWhenDragging: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          height: 42.h,
          width: MediaQuery.of(context).size.width * 0.258,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 0.7.h,
                    spreadRadius: 0.7.h,
                    color: AppColor.grayColor.withOpacity(0.15))
              ],
              borderRadius: BorderRadius.circular(8.r),
              color: AppColor.bgDark),
          child: Center(
            child: Text(text,
                style: AppFont.medium16.copyWith(
                  color: AppColor.grayColor,
                )),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          height: 42.h,
          width: MediaQuery.of(context).size.width * 0.258,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 0.7.h,
                    spreadRadius: 0.7.h,
                    color: AppColor.grayColor.withOpacity(0.25))
              ],
              borderRadius: BorderRadius.circular(8.r),
              color: AppColor.primaryColor),
          child: Center(
            child: Text(text,
                style: AppFont.medium14.copyWith(
                  color: AppColor.textDark,
                )),
          ),
        ),
      );
    }

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Secret recovery phrase',
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
          4.0.height,
          Text(
            "Drag and drop to sort your phrases exactly as you saw them on the previous screen",
            style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
          ),
          24.0.height,
          Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              alignment: WrapAlignment.center,
              spacing: 16.h,
              runSpacing: 8.h,
              direction: Axis.horizontal,
              children: [
                cardPniomoni(
                  number: 1,
                ),
                cardPniomoni(
                  number: 2,
                ),
                cardPniomoni(
                  number: 3,
                ),
                cardPniomoni(
                  number: 4,
                ),
                cardPniomoni(
                  number: 5,
                ),
                cardPniomoni(
                  number: 6,
                ),
                cardPniomoni(
                  number: 7,
                ),
                cardPniomoni(
                  number: 8,
                ),
                cardPniomoni(
                  number: 9,
                ),
                cardPniomoni(
                  number: 10,
                ),
                cardPniomoni(
                  number: 11,
                ),
                cardPniomoni(
                  number: 12,
                ),
              ]),
          controller.randomMnemonic.isEmpty
              ? const SizedBox()
              : Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            color: AppColor.grayColor.withOpacity(0.25))
                      ],
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColor.cardDark),
                  child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 8.h,
                      runSpacing: 8.h,
                      direction: Axis.horizontal,
                      children: controller.randomMnemonic
                          .map((element) => cardPilihan(text: element['data']))
                          .toList()),
                ),
          PrimaryButton(
            title: 'Confirm',
            disable: false,
            loading: false,
            onPressed: () {
              controller.validatePharse();
            },
            margin: EdgeInsets.only(top: 36.h, bottom: 36.w),
          ),
        ],
      );
    });
  }
}