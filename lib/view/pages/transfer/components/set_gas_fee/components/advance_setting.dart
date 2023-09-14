import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/theme/theme.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

class AdvanceSetting extends StatelessWidget {
  const AdvanceSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.0.height,
        InputText(
          title: "Gas Price",
          hintText: 'Enter gas price',
          icon: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'GWEI',
              style: AppFont.reguler12.copyWith(color: AppColor.grayColor),
            ),
          ),
        ),
        16.0.height,
        const InputText(title: 'Gas Limit', hintText: 'Enter gas limit')
      ],
    );
  }
}
