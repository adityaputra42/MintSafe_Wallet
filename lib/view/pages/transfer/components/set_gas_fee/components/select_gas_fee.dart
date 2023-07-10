import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

class SelectGasFee extends StatelessWidget {
  const SelectGasFee({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardGasFee() {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.cardDark),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.26,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instant',
                      style:
                          AppFont.medium14.copyWith(color: AppColor.textDark),
                    ),
                    4.0.height,
                    Text(
                      '4.50 GWEI',
                      style:
                          AppFont.reguler12.copyWith(color: AppColor.grayColor),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0.000094 BNB',
                      style:
                          AppFont.medium14.copyWith(color: AppColor.textDark),
                    ),
                    4.0.height,
                    Text(
                      '\$0.02899',
                      style:
                          AppFont.reguler12.copyWith(color: AppColor.grayColor),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.18,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Instant',
                      style:
                          AppFont.medium14.copyWith(color: AppColor.textDark),
                    ),
                    SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: AppColor.primaryColor,
                          checkColor: AppColor.textDark,
                          hoverColor: AppColor.grayColor,
                          focusColor: AppColor.grayColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        24.0.height,
        cardGasFee(),
        cardGasFee(),
        cardGasFee(),
        cardGasFee()
      ],
    );
  }
}
