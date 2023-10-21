import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/input_text.dart';

import '../../../widget/widget.dart';

class CustomToken extends StatelessWidget {
  const CustomToken({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const InputText(
              title: "Token Address", hintText: "Enter token address"),
          16.0.height,
          const InputText(
              title: "Token Symbol", hintText: "Enter token symbol"),
          16.0.height,
          const InputText(title: "Decimal", hintText: "Enter decimal"),
          const Spacer(),
          PrimaryButton(
            title: "Confirm",
            onPressed: () {},
            margin: EdgeInsets.fromLTRB(0, 16.h, 0, 32.h),
          ),
        ],
      ),
    );
  }
}
