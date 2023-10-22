import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/view/pages/add_wallet/components/alert_password.dart';
import 'package:mintsafe_wallet/view/pages/add_wallet/components/import_private_key.dart';
import 'package:mintsafe_wallet/view/pages/add_wallet/components/import_sheed_pharse.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

class AddWallet extends StatelessWidget {
  const AddWallet({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardMenu(
        {required String image,
        required String title,
        required String subTitle,
        Function()? ontap}) {
      return GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: const [
                BoxShadow(
                    spreadRadius: 0.3, blurRadius: 0.5, color: Colors.black12)
              ],
              color: AppColor.cardDark),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 32.w,
                color: AppColor.primaryColor,
              ),
              16.0.width,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFont.medium16.copyWith(color: AppColor.textDark),
                  ),
                  4.0.height,
                  Text(
                    subTitle,
                    style:
                        AppFont.reguler14.copyWith(color: AppColor.grayColor),
                  )
                ],
              )),
              16.0.width,
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20.w,
                color: AppColor.grayColor,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
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
            "Add Wallet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.0.height,
                Text(
                  "Create a new wallet",
                  style: AppFont.medium14.copyWith(color: AppColor.textDark),
                ),
                12.0.height,
                cardMenu(
                  image: AppIcon.createWalletIcon,
                  title: 'Sheed Pharse',
                  subTitle: 'Create a wallet with 12 word mnemonic pharse',
                  ontap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertPassword(
                              title: 'Create new wallet',
                              subTitle:
                                  'Enter your password to generate a mnemonic phrase to create a new wallet',
                            ));
                  },
                ),
                16.0.height,
                Text(
                  "Import an existing wallet",
                  style: AppFont.medium14.copyWith(color: AppColor.textDark),
                ),
                12.0.height,
                cardMenu(
                  image: AppIcon.importPharseIcon,
                  title: 'Seed Pharse',
                  subTitle: 'Import by 12 word mnemonic pharse',
                  ontap: () {
                    Get.to(() => ImportSheedPharse());
                  },
                ),
                12.0.height,
                cardMenu(
                  image: AppIcon.importKeyIcon,
                  title: 'Private Key',
                  subTitle: 'Import by private key',
                  ontap: () {
                    Get.to(() => ImportPrivateKey());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
