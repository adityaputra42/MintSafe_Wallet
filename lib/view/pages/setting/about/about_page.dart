import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text(
                "About MintSafe",
                style: AppFont.medium16
                    .copyWith(color: Theme.of(context).indicatorColor),
              ),
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
          Container(
            margin: EdgeInsets.all(24.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Theme.of(context).cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.0.height,
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        AppImage.logo,
                        width: 80.w,
                      ),
                      8.0.height,
                      Text(
                        'MintSafe Wallet',
                        textAlign: TextAlign.center,
                        style: AppFont.semibold14
                            .copyWith(color: Theme.of(context).indicatorColor),
                      ),
                      2.0.height,
                      Text(
                        'Wallet Version ${evm.versionApp.value}',
                        textAlign: TextAlign.center,
                        style: AppFont.medium12.copyWith(
                          color: AppColor.grayColor,
                        ),
                      ),
                    ],
                  ),
                ),
                24.0.height,
                Text(
                  'About MintSafe Wallet',
                  style: AppFont.medium14
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                8.0.height,
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    "Welcome to MintSafe Wallet, your gateway to a secure and seamless cryptocurrency experience. MintSafe Wallet is a cutting-edge cryptocurrency wallet designed to empower individuals and businesses to take full control of their digital assets while simplifying their interactions with the world of blockchain and cryptocurrency.\n\nAt MintSafe Wallet, we understand that the world of cryptocurrency can be complex and daunting for newcomers, and even experienced users can face challenges managing their digital assets. That's why we've made it our mission to provide a user-friendly, feature-rich, and secure solution that caters to both beginners and experts in the crypto space.Join the MintSafe Wallet community today and experience the future of cryptocurrency management. Whether you are a seasoned crypto enthusiast or just starting your journey, MintSafe Wallet is the secure, easy-to-use, and versatile solution you are looking for.\n\nStart your crypto adventure with MintSafe Wallet and take control of your financial future!",
                    style: AppFont.reguler14.copyWith(
                      color: AppColor.grayColor,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
