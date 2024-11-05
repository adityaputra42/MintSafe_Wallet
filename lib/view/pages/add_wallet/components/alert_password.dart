import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../widget/widget.dart';

class AlertPassword extends StatelessWidget {
  AlertPassword({super.key, required this.title, this.subTitle});
  final String title;
  final String? subTitle;
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
        height: 60.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              24.0.width,
              Expanded(
                child: Text(
                  title,
                  style: AppFont.medium16.copyWith(
                    color: Theme.of(context).indicatorColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).indicatorColor,
                  size: 24.w,
                ),
              )
            ],
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
              width: 160.w,
              fit: BoxFit.cover,
            ),
            8.0.height,
            Text(
              subTitle ?? '',
              style: AppFont.reguler14.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
              textAlign: TextAlign.center,
            ),
            16.0.height,
            InputText(
              title: 'Password',
              hintText: "Enter your password",
              onChange: evm.onchangePassword,
              controller: evm.passwordCreateAccountController,
              obscureText: evm.obsecurePassword.value,
              icon: GestureDetector(
                onTap: () {
                  evm.onchangeObsecure();
                },
                child: Icon(
                  evm.obsecurePassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 20.w,
                ),
              ),
            ),
            32.0.height,
            PrimaryButton(
              loading: evm.isLoadingCreateAccount.value,
              disable: evm.disablePassword.value,
              title: "Confirm",
              onPressed: () {
                evm.createNewAddress();
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
