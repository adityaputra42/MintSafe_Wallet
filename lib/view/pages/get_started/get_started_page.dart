import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';

import '../../../config/config.dart';
import '../../widget/widget.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgDark,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImage.maskGs), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      80.0.height,
                      Image.asset(
                        AppImage.logo,
                        width: 136.w,
                      ),
                      24.0.height,
                      Text(
                        'MintSafe',
                        style: AppFont.semibold24
                            .copyWith(color: AppColor.textDark),
                      ),
                      Text(
                        'Unlock the Future of Digital Assets',
                        style: AppFont.reguler16
                            .copyWith(color: AppColor.grayColor),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      title: "Create a New Wallet",
                      onPressed: () {
                        Get.to(() => CreateNewWalletPage());
                      },
                    ),
                    24.0.height,
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Have an existing wallet? ',
                          style: AppFont.reguler16
                              .copyWith(color: AppColor.grayColor)),
                      TextSpan(
                        text: 'Import Wallet',
                        style: AppFont.medium16
                            .copyWith(color: AppColor.primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => ImportWalletPage()),
                      )
                    ])),
                    48.0.height,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
