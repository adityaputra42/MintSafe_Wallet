import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';
import 'package:mintsafe_wallet/view/widget/input_text.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';

import '../../../config/config.dart';

class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.0.height,
          Text(
            'Import via Seed Phrase',
            style: AppFont.medium16.copyWith(color: AppColor.textDark)
          ),
          4.0.height,
          Text(
            'To import an existing wallet, please enter the recovery seed phrase here:',
            style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
          ),
          24.0.height,
          InputText(
            title: "Secret Pharse",
            hintText: 'Enter your secret pharse',
            textInputAction: TextInputAction.next,
            maxLine: 4,
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                8.0.width,
                Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 32.h,
                ),
                24.0.width
              ],
            ),
          ),
          InputText(
            title: "Password",
            hintText: 'Enter your password',
            obscureText: true,
            textInputAction: TextInputAction.next,
            icon: Icon(
              Icons.visibility,
              size: 22.h,
            ),
          ),
          InputText(
            title: "Confirm Password",
            hintText: 'Confirm your password',
            textInputAction: TextInputAction.done,
            obscureText: true,
            icon: Icon(
              Icons.visibility,
              size: 22.h,
            ),
          ),
          ListTileTheme(
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.zero,
            child: CheckboxListTile(
                title: Text.rich(
                  TextSpan(
                    text: 'I read and agreed to the',
                    style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                    children: [
                      TextSpan(
                          text: ' Term of Service',
                          style: AppFont.medium14.copyWith(
                            color: AppColor.primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {}),
                    ],
                  ),
                ),
                dense: true,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: false,
                activeColor: AppColor.primaryColor,
                onChanged: (newValue) async {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r))),
          ),
          PrimaryButton(
            title: 'Import Wallet',
            disable: false,
            loading: false,
            onPressed: () {
            
            },
            margin: EdgeInsets.only(top: 24.h, bottom: 36.w),
          ),
        ],
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
            "Import an Existing Wallet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: body()),
        ),
      ),
    );
  }
}
