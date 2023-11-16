import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.onChange,
    this.validator,
    this.controller,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
  });

  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: AppFont.medium14.copyWith(color: Theme.of(context).indicatorColor,),
        controller: controller,
        onChanged: onChange,
        validator: validator,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        focusNode: focusNode,
        decoration: InputDecoration(
            fillColor: Theme.of(context).cardColor,
            filled: true,
            suffixIcon: Icon(
              Icons.search,
              size: 20.w,
            ),
            hintText: "Search",
            hintStyle: AppFont.reguler14.copyWith(
                fontWeight: FontWeight.w300, color: AppColor.grayColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColor.primaryColor),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w)),
      ),
    );
  }
}
