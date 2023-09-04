import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/create_wallet_controller.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/confirm_sheed_pharse.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/create_password.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/sheed_pharse.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/stepper.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

class CreateNewWalletPage extends StatelessWidget {
  CreateNewWalletPage({super.key});

  final CreateWalletController controller = Get.put(CreateWalletController());

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            StepperCustom(
              controller: controller,
            ),
            24.0.height,
            controller.stepIndex.value == 0
                ? CreatePassword(
                    controller: controller,
                  )
                : controller.stepIndex.value == 1
                    ? SheedPharse(
                        controller: controller,
                      )
                    : ConfirmSheedPharse()
          ],
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.changeStep(0);
              controller.password.clear();
              controller.confirmPassword.clear();
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Create a New Wallet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: ScreenUtil().screenHeight,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              )),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: body(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
