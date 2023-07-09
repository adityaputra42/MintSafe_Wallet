import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/succes_create_wallet.dart';

import '../../../../config/config.dart';
import '../../../../domain/controller/create_wallet_controller.dart';
import '../../../widget/widget.dart';

class ConfirmSheedPharse extends StatelessWidget {
  const ConfirmSheedPharse({super.key, required this.controller});
  final CreateWalletController controller;
  @override
  Widget build(BuildContext context) {
    Widget cardPniomoni({required int number, String? text}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        height: 42.h,
        width: MediaQuery.of(context).size.width * 0.425,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 0.5.h,
              spreadRadius: 0.5.h,
              color: AppColor.primaryColor.withOpacity(0.15))
        ], borderRadius: BorderRadius.circular(8.r), color: AppColor.cardDark),
        child: Text("$number. ${text ?? ''}",
            style: AppFont.medium16.copyWith(
              color: AppColor.primaryColor,
            )),
      );
    }

    Widget cardPilihan({required String text}) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        height: 42.h,
        width: MediaQuery.of(context).size.width * 0.258,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.7.h, spreadRadius: 0.7.h, color: AppColor.primaryColor.withOpacity(0.15))
            ],
            borderRadius: BorderRadius.circular(8.r),
            color: AppColor.primaryColor),
        child: Center(
          child: Text(text,
              style: AppFont.medium16.copyWith(
                color: AppColor.textDark,
              )),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Secret recovery phrase',
          style: AppFont.medium16.copyWith(color: AppColor.textDark),
        ),
        4.0.height,
        Text(
          "This 12-word phrase allows you to recover your wallet and access to the coins inside.",
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
        16.0.height,
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: AppColor.primaryColor.withOpacity(0.15))
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
              children: [
                cardPilihan(text: "Gasket"),
                cardPilihan(text: "Piston"),
                cardPilihan(text: "Allow"),
                cardPilihan(text: "Minion"),
                cardPilihan(text: "puly"),
                cardPilihan(text: "Engine"),
                cardPilihan(text: "Break"),
                cardPilihan(text: "Velg"),
                cardPilihan(text: "crank"),
                cardPilihan(text: "gardan"),
                cardPilihan(text: "casis"),
                cardPilihan(text: "body"),
              ]),
        ),
        PrimaryButton(
          title: 'Confirm',
          disable: false,
          loading: false,
          onPressed: () {
            Get.to(() =>const SuccesCreateWallet());
          },
          margin: EdgeInsets.only(top: 36.h, bottom: 36.w),
        ),
      ],
    );
  }
}
