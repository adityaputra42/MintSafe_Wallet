import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';

import '../../config/config.dart';

class InputText extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obscureText;
  final Widget? icon;
  final Function()? ontaped;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLine;
  final Widget? crossTitle;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  const InputText({
    Key? key,
    this.obscureText = false,
    required this.title,
    required this.hintText,
    this.onChange,
    this.ontaped,
    this.textInputAction,
    this.icon,
    this.maxLine = 1,
    this.crossTitle,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppFont.medium16.copyWith(color: AppColor.textDark)),
            crossTitle ?? const SizedBox()
          ],
        ),
        8.0.height,
        TextFormField(
            focusNode: focusNode,
            onChanged: onChange,
            validator: validator,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            onTap: ontaped,
            maxLines: maxLine,
            style: AppFont.medium14.copyWith(color: AppColor.textDark),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 12.h),
              suffixIcon: icon,
             
              hintText: hintText,
              hintStyle: AppFont.reguler14.copyWith(
                  fontWeight: FontWeight.w300, color: AppColor.grayColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: AppColor.grayColor,width: 0.5
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                   color: AppColor.grayColor,width: 0.5
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
            )
            // contentPadding:
            //     EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h)),
            ),
      ],
    );
  }
}
