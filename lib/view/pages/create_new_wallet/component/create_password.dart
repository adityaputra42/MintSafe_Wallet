import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';

import '../../../widget/widget.dart';

final obsecurePassword = StateProvider<bool>((ref) => false);

final obsecureConfirmPassword = StateProvider<bool>((ref) => false);

final tosProvider = StateProvider<bool>((ref) => false);

class CreatePassword extends ConsumerWidget {
  const CreatePassword({
    super.key,
  });
  // final CreateWalletController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create a password',
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
            textInputAction: TextInputAction.next,
            icon: GestureDetector(
              onTap: () => ref.read(obsecurePassword.notifier).state =
                  !ref.read(obsecurePassword.notifier).state,
              child: Icon(
                ref.watch(obsecurePassword)
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 22.h,
              ),
            ),
          ),
          InputText(
            title: "Confirm Password",
            hintText: 'Confirm your password',
            textInputAction: TextInputAction.done,
            icon: GestureDetector(
              onTap: () => ref.read(obsecureConfirmPassword.notifier).state =
                  !ref.read(obsecureConfirmPassword.notifier).state,
              child: Icon(
                ref.watch(obsecureConfirmPassword)
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 22.h,
              ),
            ),
          ),
          8.0.height,
          Row(
            children: [
              8.0.width,
              SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: Checkbox(
                    activeColor: AppColor.primaryColor,
                    value: ref.watch(tosProvider),
                    onChanged: (value) {
                      ref.read(tosProvider.notifier).state = value ?? false;
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                  )),
              16.0.width,
              Text.rich(
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
            ],
          ),
          PrimaryButton(
            title: 'Continue',
            loading: false,
            onPressed: () {
              ref.read(stepProvider.notifier).state = 1;
            },
            margin: EdgeInsets.only(top: 36.h, bottom: 36.w),
          ),
        ],
      );
    });
  }
}
