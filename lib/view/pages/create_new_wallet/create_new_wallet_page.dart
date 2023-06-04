import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/confirm_sheed_pharse.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/stepper.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

class CreateNewWalletPage extends StatelessWidget {
  const CreateNewWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.0.height,
          const StepperCustom(currentStep: 2),
          24.0.height,
          const ConfirmSheedPharse()
        ],
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackText,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Create a New Wallet",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: body(),
          ),
        ),
      ),
    );
  }
}
