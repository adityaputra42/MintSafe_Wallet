import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../domain/controller/create_wallet_controller.dart';
import '../../../widget/widget.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key, required this.controller});
  final CreateWalletController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a password',
              style: AppFont.medium16.copyWith(color: Theme.of(context).indicatorColor),
            ),
            6.0.height,
            Text(
              "You'll use this to unlock your wallet",
              style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
            ),
            24.0.height,
            InputText(
              title: "Password",
              hintText: 'Enter your password',
              controller: controller.password,
              onChange: controller.onChangePassword,
              validator: controller.onValidatePassword,
              obscureText: controller.isPasswordHide.value,
              textInputAction: TextInputAction.next,
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
            controller.strengthPassword.value <= 0
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
                              percent: controller.strengthPassword.value,
                              backgroundColor: AppColor.grayColor,
                              progressColor: controller.color.value),
                        ),
                        16.0.width,
                        Text(
                          controller.strength.value,
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
              onChange: controller.onChangeConfirmPassword,
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
              title: 'Continue',
              disable: controller.buttonPassword.value,
              loading: false,
              onPressed: () {
                controller.changeStep(1);
              },
              margin: EdgeInsets.only(top: 36.h, bottom: 36.w),
            ),
          ],
        ),
      );
    });
  }
}
