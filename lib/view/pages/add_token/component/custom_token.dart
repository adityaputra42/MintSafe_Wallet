import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../domain/controller/controller.dart';
import '../../../widget/widget.dart';

class CustomToken extends StatelessWidget {
  CustomToken({super.key});
  final AddTokenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Warning(
              warning:
                  "Make sure you enter the correct information according to the ${controller.evm.selectedChain.value.name} network."),
          16.0.height,
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
