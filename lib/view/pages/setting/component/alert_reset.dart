import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../widget/widget.dart';

class AlertResetWallet extends StatelessWidget {
  AlertResetWallet({
    super.key,
  });

  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
        height: 60.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        child: Center(
          child: Text(
            "Reset Wallet",
            style: AppFont.medium16.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    Widget content() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Warning(
              warning:
                  'Resetting the wallet means deleting all data in this application, make sure you have backed up the secret parse or private key from your account.'),
          16.0.height,
          Text(
            'Are you sure you want to reset this wallet?',
            style: AppFont.reguler14.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
            textAlign: TextAlign.center,
          ),
          24.0.height,
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  title: "Cancel",
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              8.0.width,
              Expanded(
                child: SecondaryButton(
                  title: "Reset",
                  onPressed: () {
                    evm.resetWallet();
                  },
                ),
              )
            ],
          )
        ],
      );
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      titlePadding: EdgeInsets.zero,
      title: header(),
      contentPadding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
