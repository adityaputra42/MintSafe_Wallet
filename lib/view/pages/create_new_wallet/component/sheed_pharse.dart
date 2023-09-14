import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/helper/method_helper.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../../domain/controller/create_wallet_controller.dart';
import '../../../widget/widget.dart';

class SheedPharse extends StatelessWidget {
  const SheedPharse({super.key, required this.controller});
  final CreateWalletController controller;
  @override
  Widget build(BuildContext context) {
    Widget cardPniomoni({required int number, required String text}) {
      return Container(
        height: 42.h,
        width: MediaQuery.of(context).size.width * 0.425,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 0.1,
              spreadRadius: 0.1,
              color: AppColor.grayColor.withOpacity(0.25))
        ], borderRadius: BorderRadius.circular(8.r), color: AppColor.cardDark),
        child: Text("$number. $text",
            style: AppFont.medium14.copyWith(
              color: AppColor.textDark,
            )),
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
            children: controller.mnemonic
                .map(
                  (e) => cardPniomoni(number: e['id'], text: e['data']),
                )
                .toList()),
        SecondaryButton(
          title: "Backup Pharse",
          onPressed: () {
            MethodHelper().handleCopy(data: controller.mnemonicText.value);
          },
          margin: EdgeInsets.only(top: 36.h),
        ),
        PrimaryButton(
          title: 'Continue',
          disable: false,
          loading: false,
          onPressed: () {
            controller.changeStep(2);
            controller.setRandom();
          },
          margin: EdgeInsets.only(top: 16.h, bottom: 36.w),
        ),
      ],
    );
  }
}
