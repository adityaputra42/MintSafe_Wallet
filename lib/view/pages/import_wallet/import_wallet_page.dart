import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/import_waller_controller.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';
import 'package:mintsafe_wallet/view/widget/input_text.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';

class ImportWalletPage extends StatelessWidget {
  ImportWalletPage({super.key});
  final ImportWalletController controller = Get.put(ImportWalletController());

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Obx(() {
        return Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              Text('Import via Seed Phrase',
                  style: AppFont.medium16.copyWith(color: AppColor.textDark)),
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
                controller: controller.sheedPharse,
                onChange: controller.onChangePharse,
                validator: controller.onValidatePharse,
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
              16.0.height,
              InputText(
                title: "Password",
                hintText: 'Enter your password',
                obscureText: controller.isPasswordHide.value,
                textInputAction: TextInputAction.next,
                controller: controller.password,
                onChange: controller.onChangePassword,
                validator: controller.onValidatePassword,
                icon: GestureDetector(
                  onTap: () => controller.changeHidePassword(),
                  child: Icon(
                    controller.isPasswordHide.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 22.h,
                  ),
                ),
              ),
              controller.strength.value <= 0
                  ? 16.0.height
                  : Padding(
                      padding: EdgeInsets.only(bottom: 16.h, top: 12.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: LinearPercentIndicator(
                                // width: ScreenUtil().screenWidth * 0.78,
                                barRadius: Radius.circular(3.h),
                                lineHeight: 8.h,
                                animation: true,
                                animationDuration: 500,
                                padding: EdgeInsets.zero,
                                percent: controller.strength.value,
                                backgroundColor: AppColor.grayColor,
                                progressColor: controller.color.value),
                          ),
                          16.0.width,
                          Text(
                            controller.strengthPassword.value,
                            style: AppFont.semibold14
                                .copyWith(color: controller.color.value),
                          )
                        ],
                      ),
                    ),
              InputText(
                title: "Confirm Password",
                hintText: 'Confirm your password',
                textInputAction: TextInputAction.done,
                obscureText: controller.isConfirmHide.value,
                controller: controller.confirmPassword,
                validator: controller.onValidateConfirm,
                onChange: controller.onChangeConfirm,
                icon: GestureDetector(
                  onTap: () => controller.changeHideConfirm(),
                  child: Icon(
                    controller.isConfirmHide.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 22.h,
                  ),
                ),
              ),
              24.0.height,
              Row(
                children: [
                  8.0.width,
                  SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: Checkbox(
                        activeColor: AppColor.primaryColor,
                        value: controller.isAggree.value,
                        onChanged: (value) {
                          controller.changeAggrement(value ?? false);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r)),
                      )),
                  16.0.width,
                  Text.rich(
                    TextSpan(
                      text: 'I read and agreed to the',
                      style:
                          AppFont.reguler14.copyWith(color: AppColor.grayColor),
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
                ],
              ),
              PrimaryButton(
                title: 'Import Wallet',
                disable: controller.buttonImport.value,
                loading: controller.isLoading.value,
                onPressed: () {
                  controller.import(controller.sheedPharse.text);
                },
                margin: EdgeInsets.only(top: 32.h, bottom: 36.w),
              ),
            ],
          ),
        );
      });
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
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: ScreenUtil().screenHeight,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              )),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: body()),
            ),
          ),
        ],
      ),
    );
  }
}
