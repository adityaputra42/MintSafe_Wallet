import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';

import '../../../widget/widget.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create a password',
          style: AppFont.semibold18,
        ),
        Text(
          "You'll use this to unlock your wallet",
          style: AppFont.reguler14,
        ),
        24.0.height,
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
                  style: AppFont.reguler14,
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
          title: 'Continue',
          disable: false,
          loading: false,
          onPressed: () {},
          margin: EdgeInsets.only(top: 24.h, bottom: 36.w),
        ),
      ],
    );
  }
}
