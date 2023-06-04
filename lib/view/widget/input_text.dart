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
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppFont.medium16),
          12.0.height,
          TextFormField(
            focusNode: focusNode,
            onChanged: onChange,
            validator: validator,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            cursorColor: Theme.of(context).indicatorColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            onTap: ontaped,
            cursorHeight: 24.h,
            maxLines: maxLine,
            style: AppFont.medium14,
            decoration: InputDecoration(
              suffixIcon: icon,filled: true,fillColor: AppColor.white,
              hintText: hintText,
              hintStyle: AppFont.reguler14.copyWith(
                  fontWeight: FontWeight.w300, color: AppColor.darkerGray),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
