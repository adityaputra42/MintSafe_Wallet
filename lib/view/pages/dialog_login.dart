import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/home_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../widget/widget.dart';

class DialogLogin extends StatelessWidget {
  DialogLogin({super.key});
  final HomeController controller =
      Get.isRegistered() ? Get.find() : Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Center(
          child: Text(
            "session has expired",
            style: AppFont.medium16.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    Widget content() {
      return Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImage.ilustrasi6,
              width: 120.w,
              fit: BoxFit.cover,
            ),
            8.0.height,
            Text(
              'your session has expired, please enter your password to access this wallet',
              style: AppFont.reguler14.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
              textAlign: TextAlign.center,
            ),
            16.0.height,
            InputText(
              title: 'Password',
              hintText: "Enter your password",
              controller: controller.passwordTextController,
              obscureText: controller.obsecurePassword.value,
              onChange: controller.onChangePassword,
              icon: GestureDetector(
                onTap: () {
                  controller.changeObesure();
                },
                child: Icon(
                  controller.obsecurePassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20.w,
                ),
              ),
            ),
            32.0.height,
            PrimaryButton(
              title: "Confirm",
              height: 48,
              disable: controller.buttonDiasable.value,
              loading: controller.isLoadingLogin.value,
              onPressed: () {
                controller.login();
              },
            )
          ],
        );
      });
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      titlePadding: EdgeInsets.zero,
      title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
