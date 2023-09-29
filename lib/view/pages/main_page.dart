import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/controller.dart';
import 'package:mintsafe_wallet/view/pages/dapp/dapp_page.dart';
import 'package:mintsafe_wallet/view/pages/discover/discover_page.dart';
import 'package:mintsafe_wallet/view/pages/setting/setting_page.dart';

import '../../config/config.dart';
import 'Home_page/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.address});
  final Address address;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final BottomNavBarController controller = Get.put(BottomNavBarController());
  late EvmController evm;

  @override
  void initState() {
    evm = Get.put(EvmController(address: widget.address));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    body() {
      switch (controller.indexBar.value) {
        case 0:
          return HomePage(
            evm: evm,
          );
        case 1:
          return const DiscoverPage();
        case 2:
          return const DAppPage();

        case 3:
          return const SettingPage();

        default:
          HomePage(
            evm: evm,
          );
      }
    }

    return Obx(() {
      return Scaffold(
        backgroundColor: AppColor.bgDark,
        body: body(),
        bottomNavigationBar: Container(
          width: double.infinity,
          // height: 72.h,
          decoration: BoxDecoration(
              color: AppColor.cardDark,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1.h, blurRadius: 1.h, color: Colors.black12)
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.w),
                topRight: Radius.circular(12.w),
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
                          color: AppColor.primaryColor,
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
                            color: AppColor.primaryColor,
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
                            color: AppColor.primaryColor,
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
                            color: AppColor.primaryColor,
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
                  unselectedItemColor: AppColor.grayColor,
                  showUnselectedLabels: true,
                  unselectedLabelStyle:
                      AppFont.medium12.copyWith(color: AppColor.grayColor),
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
