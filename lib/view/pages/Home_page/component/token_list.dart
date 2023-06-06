import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenList extends StatelessWidget {
  const TokenList({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardToken() {
      return Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(spreadRadius: 0.4, blurRadius: 0.5.h, color: Colors.black12)
        ], borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      );
    }

    return Expanded(
        child: ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 0.5.h),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: cardToken(),
      ),
      itemCount: 3,
    ));
  }
}
