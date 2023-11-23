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
  final bool enable;
  final bool autoFocus;
  const InputText({
    Key? key,
    this.obscureText = false,
    required this.title,
    required this.hintText,
    this.enable = true,
    this.autoFocus = false,
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
            Text(title,
                style: AppFont.medium14.copyWith(
                  color: Theme.of(context).indicatorColor,
                )),
            crossTitle ?? const SizedBox()
          ],
        ),
        8.0.height,
        TextFormField(
            focusNode: focusNode,
            onChanged: onChange,
            validator: validator,
            autofocus: autoFocus,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            controller: controller,
            onTap: ontaped,
            maxLines: maxLine,
            style: AppFont.medium14.copyWith(
              color: enable
                  ? Theme.of(context).indicatorColor
                  : AppColor.grayColor,
            ),
            decoration: InputDecoration(
              enabled: enable,
              filled: true,
              fillColor: Theme.of(context).cardColor,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              suffixIcon: icon,
              hintText: hintText,
              hintStyle: AppFont.reguler14.copyWith(
                  fontWeight: FontWeight.w300, color: AppColor.grayColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide:
                    const BorderSide(color: Colors.transparent, width: 0.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: AppColor.primaryColor),
              ),
            )),
      ],
    );
  }
}
