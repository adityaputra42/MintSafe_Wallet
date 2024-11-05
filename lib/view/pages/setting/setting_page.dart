import 'package:blockies_ethereum/blockies_ethereum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/domain/controller/theme_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/setting/about/about_page.dart';
import 'package:mintsafe_wallet/view/pages/setting/component/alert_reset.dart';
import 'package:mintsafe_wallet/view/pages/setting/network/network_setting.dart';
import 'package:mintsafe_wallet/view/pages/setting/security/security_page.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/config.dart';
import '../../../data/src/src.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final EvmNewController controller = Get.find();
  final ThemeController themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardMenu(
        {required IconData icon,
        required String title,
        Widget? widget,
        Function()? onTap}) {
      return GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    blurRadius: 0.3, spreadRadius: 0.5, color: Colors.black12)
              ],
              borderRadius: BorderRadius.circular(8.r),
              color: Theme.of(context).cardColor),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.h,
                color: AppColor.primaryColor,
              ),
              12.0.width,
              Expanded(
                  child: Text(
                title,
                style: AppFont.medium16.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
              )),
              8.0.width,
              widget ?? const SizedBox(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(() {
        return SafeArea(
            child: Stack(
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  24.0.height,
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        padding: EdgeInsets.all(4.h),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2.h, color: AppColor.primaryColor)),
                        child: Center(
                          child: Blockies(
                              size: 0.7,
                              data: controller.selectedAddress.value.address ??
                                  "-",
                              shape: BlockiesShape.circle),
                        ),
                      ),
                      12.0.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Wallets",
                            style: AppFont.reguler16
                                .copyWith(color: AppColor.grayColor),
                          ),
                          Text(
                            "${controller.selectedAddress.value.name ?? ""} ${controller.selectedAddress.value.id ?? ""}",
                            style: AppFont.medium16.copyWith(
                              color: Theme.of(context).indicatorColor,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  12.0.height,
                  const Divider(
                    thickness: 1,
                    color: AppColor.grayColor,
                  ),
                  16.0.height,
                  cardMenu(
                    icon: Icons.share_outlined,
                    title: "Share My Public Address",
                    widget: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24.w,
                      color: Theme.of(context).indicatorColor,
                    ),
                    onTap: () {
                      Share.share(
                          controller.selectedAddress.value.address ?? '');
                    },
                  ),
                  16.0.height,
                  cardMenu(
                      icon: Icons.network_wifi_3_bar_rounded,
                      title: "Network",
                      onTap: () {
                        Get.to(() => NetworkSetting());
                      },
                      widget: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24.w,
                        color: Theme.of(context).indicatorColor,
                      )),
                  16.0.height,
                  cardMenu(
                      icon: Icons.settings_outlined,
                      title: "Security & Privacy",
                      onTap: () {
                        Get.to(() => SecurityPage());
                      },
                      widget: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24.w,
                        color: Theme.of(context).indicatorColor,
                      )),
                  16.0.height,
                  cardMenu(
                    icon: Icons.dark_mode_outlined,
                    title: "Dark Mode",
                    widget: FlutterSwitch(
                      width: 50.w,
                      height: 24.h,
                      activeColor: AppColor.primaryColor,
                      inactiveColor: AppColor.grayColor,
                      valueFontSize: 20.0,
                      toggleSize: 20.h,
                      value: themeController.darkTheme.value,
                      borderRadius: 16,
                      padding: 2,
                      showOnOff: false,
                      onToggle: (val) {
                        themeController.setDarkTheme(val);
                      },
                    ),
                  ),
                  16.0.height,
                  cardMenu(
                      icon: Icons.info_outline_rounded,
                      title: "About",
                      onTap: () {
                        Get.to(() => AboutPage());
                      },
                      widget: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24.w,
                        color: Theme.of(context).indicatorColor,
                      )),
                  16.0.height,
                  cardMenu(
                      icon: Icons.logout,
                      title: "Reset Wallet",
                      onTap: () {
                        Get.dialog(AlertResetWallet());
                      },
                      widget: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24.w,
                        color: Theme.of(context).indicatorColor,
                      )),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }
}
