import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/setting/security/alert_password_security.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../../config/config.dart';
import '../../../../domain/controller/evm_new_controller.dart';
import '../../../../domain/controller/security_privacy_controller.dart';

class SecurityPage extends StatelessWidget {
  SecurityPage({super.key});
  final EvmNewController evm = Get.find();
  final SecurityPrivasyController controller =
      Get.put(SecurityPrivasyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: WidgetHelper.appBar(
          context: context,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).indicatorColor,
                  size: 24.h,
                ),
              ),
              16.0.width,
              Text("Security & Privacy",
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor)),
            ],
          )),
      body: Stack(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            child: Image.asset(
              AppImage.maskHome,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Protect Your Wallet',
                        style: AppFont.medium14.copyWith(
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      16.0.height,
                      const Warning(
                        warning:
                            'This is your recovery phrase. Write it down on a paper and keep it in a safe place. You\'ll be asked to re-enter this phrase (in order) on the next step.',
                      ),
                      16.0.height,
                      PrimaryButton(
                        title: 'Reveal Recovery Phrase',
                        onPressed: () {
                          Get.dialog(AlertPasswordSecurity(
                            title: "Reveal Recovery Phrase",
                            subTitle:
                                'Enter your password to reveal recovery phrase',
                            onTap: () {
                              controller.validatePasswordMnmonic();
                            },
                          ));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Show Private Key for "${evm.selectedAddress.value.name} ${evm.selectedAddress.value.id}"',
                        style: AppFont.medium14.copyWith(
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      16.0.height,
                      Warning(
                        warning:
                            'This is the private key for "${evm.selectedAddress.value.name} ${evm.selectedAddress.value.id}". Never disclose this key, anyone who have your private key can fully control your account. Beware of any scam and fraud.',
                      ),
                      16.0.height,
                      PrimaryButton(
                        title: 'Show Private Key',
                        onPressed: () {
                          Get.dialog(AlertPasswordSecurity(
                            title: "Show Private Key",
                            subTitle: 'Enter your password to show private key',
                            onTap: () {
                              controller.validatePasswordPrivateKey();
                            },
                          ));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
