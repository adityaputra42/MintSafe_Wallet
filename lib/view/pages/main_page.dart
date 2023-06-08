import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/controller.dart';
import 'package:mintsafe_wallet/view/pages/setting/setting_page.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../config/config.dart';
import 'Home_page/home_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final BottomNavBarController controller = Get.put(BottomNavBarController());
  @override
  Widget build(BuildContext context) {
    body() {
      switch (controller.indexBar.value) {
        case 0:
          return HomePage();
        case 1:
          return const Center(
            child: Text("Discover"),
          );
        case 2:
          return const Center(
            child: Text("DApp"),
          );

        case 3:
          return const SettingPage();

        default:
          HomePage();
      }
    }

    return Obx(() {
      return ScaffoldGradientBackground(
        gradient: AppGradient.background,
        body: body(),
        bottomNavigationBar: Container(
          width: double.infinity,
          // height: 80.h,
          decoration: BoxDecoration(
              gradient: AppGradient.bottomNavBar,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.5.h,
                    blurRadius: 0.5.h,
                    color: Colors.black12)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.w),
                topRight: Radius.circular(24.w),
              )),
          child: Obx(() {
            return Stack(
              alignment: Alignment.center,
              children: [
                BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.walletInactive,
                            width: 32.h,
                          )),
                      activeIcon: Padding(
                        padding: EdgeInsets.all(4.h),
                        child: Image.asset(
                          AppIcon.walletActive,
                          width: 32.h,
                        ),
                      ),
                      label: 'Wallet',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.diacoverInactive,
                            width: 32.h,
                          )),
                      activeIcon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.discoverActive,
                            width: 32.h,
                          )),
                      label: 'Discover',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.dappInactive,
                            width: 32.h,
                          )),
                      activeIcon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.dappActive,
                            width: 32.h,
                          )),
                      label: 'DApp',
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.settingInactive,
                            width: 32.h,
                          )),
                      activeIcon: Padding(
                          padding: EdgeInsets.all(4.h),
                          child: Image.asset(
                            AppIcon.settingActive,
                            width: 32.h,
                          )),
                      label: 'Settings',
                    ),
                  ],
                  elevation: 0,
                  currentIndex: controller.indexBar.value,
                  onTap: (value) => controller.changeIndexBar(value),
                  backgroundColor: Colors.transparent,
                  selectedItemColor: AppColor.primaryColor,
                  selectedLabelStyle: AppFont.semibold12,
                  unselectedItemColor: AppColor.darkerGray,
                  showUnselectedLabels: true,
                  unselectedLabelStyle:
                      AppFont.medium12.copyWith(color: AppColor.darkerGray),
                ),
                // evm.isLoadingNetwork.value
                //     ? Container(
                //         decoration:
                //             BoxDecoration(color: Colors.black.withOpacity(0.3)),
                //       )
                //     : const SizedBox()
              ],
            );
          }),
        ),
      );
    });
  }
}
