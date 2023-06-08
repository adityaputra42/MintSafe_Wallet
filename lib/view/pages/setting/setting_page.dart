import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../data/src/src.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardMenu(
        {required IconData icon, required String title, Widget? widget}) {
      return Row(
        children: [
          Icon(
            icon,
            size: 24.h,
            color: AppColor.primaryColor,
          ),
          12.0.width,
          Expanded(
              child: Text(
            title,
            style: AppFont.medium16,
          )),
          8.0.width,
          widget ?? const SizedBox(),
        ],
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            24.0.height,
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.w,
                  padding: EdgeInsets.all(3.h),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 2.h, color: AppColor.primaryColor)),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryColor,
                    ),
                    child: Image.asset(
                      AppImage.avatar,
                    ),
                  ),
                ),
                8.0.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Wallets",
                      style: AppFont.reguler16,
                    ),
                    Text(
                      "Dompet Saya",
                      style: AppFont.medium16,
                    )
                  ],
                )
              ],
            ),
            12.0.height,
            const Divider(
              thickness: 1,
              color: AppColor.darkerGray,
            ),
            16.0.height,
            cardMenu(icon: Icons.people_outline_rounded, title: "Contact"),
            16.0.height,
            cardMenu(
                icon: Icons.cast_connected_outlined, title: "Wallet Connect"),
            16.0.height,
            cardMenu(
                icon: Icons.settings_outlined, title: "Security & Privacy"),
            16.0.height,
            cardMenu(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              widget: FlutterSwitch(
                width: 42.w,
                height: 22.h,
                activeColor: AppColor.primaryColor,
                inactiveColor: AppColor.gray,
                valueFontSize: .0,
                toggleSize: 18.h,
                value: true,
                borderRadius: 12.h,
                padding: 2.h,
                showOnOff: false,
                onToggle: (val) {},
              ),
            ),
            16.0.height,
            cardMenu(icon: Icons.logout, title: "Reset Wallet"),
          ],
        ),
      )),
    );
  }
}
