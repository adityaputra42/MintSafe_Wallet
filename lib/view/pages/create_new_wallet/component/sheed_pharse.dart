import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 0.5,
              spreadRadius: 0.7,
              color: AppColor.primaryColor.withOpacity(0.15))
        ], borderRadius: BorderRadius.circular(8.r), color: AppColor.cardDark),
        child: Center(
          child: Text("$number. $text",
              style: AppFont.medium16.copyWith(
                color: AppColor.primaryColor,
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
              cardPniomoni(number: 1, text: "Gasket"),
              cardPniomoni(number: 2, text: "Piston"),
              cardPniomoni(number: 3, text: "Allow"),
              cardPniomoni(number: 4, text: "Minion"),
              cardPniomoni(number: 5, text: "puly"),
              cardPniomoni(number: 6, text: "Engine"),
              cardPniomoni(number: 7, text: "Break"),
              cardPniomoni(number: 8, text: "Velg"),
              cardPniomoni(number: 9, text: "crank"),
              cardPniomoni(number: 10, text: "gardan"),
              cardPniomoni(number: 11, text: "casis"),
              cardPniomoni(number: 12, text: "body"),
            ]),
        SecondaryButton(
          title: "Backup Pharse",
          onPressed: () {},
          margin: EdgeInsets.only(top: 36.h),
        ),
        PrimaryButton(
          title: 'Continue',
          disable: false,
          loading: false,
          onPressed: () {
            controller.changeStep(2);
          },
          margin: EdgeInsets.only(top: 16.h, bottom: 36.w),
        ),
      ],
    );
  }
}
