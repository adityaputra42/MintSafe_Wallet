import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:mintsafe_wallet/view/widget/secondary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../config/config.dart';
import '../../../../domain/controller/evm_new_controller.dart';
import '../../../../domain/controller/security_privacy_controller.dart';
import '../../../../utils/helper/helper.dart';

class SecurityPage extends StatelessWidget {
  SecurityPage({super.key});
  final EvmNewController evm = Get.find();
  final SecurityPrivasyController controller =
      Get.put(SecurityPrivasyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      appBar: WidgetHelper.appBar(context: context,
          title: Text(
        "Security",
      )),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                  decoration: BoxDecoration(
                    color: AppColor.yellowColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        AppImage.empty,
                        width: 40.w,
                      ),
                      16.0.width,
                      Flexible(
                        child: Text(
                          'This is your recovery phrase. Write it down on a paper and keep it in a safe place. You\'ll be asked to re-enter this phrase (in order) on the next step.',
                          style: AppFont.reguler12.copyWith(
                            color: AppColor.yellowColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  title: 'Reveal Recovery Phrase',
                  onPressed: () {
                    controller.inactiveStateSheedPharse();
                    Get.bottomSheet(
                      Obx(() {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 32.h),
                          child: controller.isValid.value
                              ? activePhrase(context)
                              : inputPassword(
                                  context,
                                  title: 'Reveal Recovery Phrase',
                                  confirmText: 'Reveal',
                                  onTap: () =>
                                      controller.validatePasswordMnmonic(),
                                ),
                        );
                      }),
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                      isDismissible: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
                Text(
                  'This is the private key for "${evm.selectedAddress.value.name} ${evm.selectedAddress.value.id}". Never disclose this key, anyone who have your private key can fully control your account. Beware of any scam and fraud.',
                  style: AppFont.reguler12.copyWith(
                    color: Theme.of(context).indicatorColor,
                  ),
                ),
                16.0.height,
                PrimaryButton(
                  title: 'Show Private Key',
                  onPressed: () {
                    controller.inactiveStateSheedPharse();
                    Get.bottomSheet(
                      Obx(() {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 32.h),
                          child: controller.isValid.value
                              ? activePrivateKey(context)
                              : inputPassword(
                                  context,
                                  title: 'Show Private Key',
                                  confirmText: 'Show',
                                  onTap: () =>
                                      controller.validatePasswordPrivateKey(),
                                ),
                        );
                      }),
                      backgroundColor: Theme.of(context).cardColor,
                      elevation: 0,
                      isDismissible: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget inputPassword(
    BuildContext context, {
    required String title,
    required String confirmText,
    required Function() onTap,
  }) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppIcon.discoverActive,
            width: 80.w,
          ),
          16.0.height,
          Text(
            title,
            style: AppFont.semibold16.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
          ),
          16.0.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password',
              style: AppFont.medium12.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          8.0.height,
          TextFormField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16.w),
              hintText: 'Type your account name',
              hintStyle: AppFont.reguler12.copyWith(
                color: AppColor.grayColor,
              ),
              filled: true,
              fillColor: Theme.of(context).hintColor.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          24.0.height,
          Row(
            children: [
              Flexible(
                child: SecondaryButton(
                  title: 'Cancel',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              8.0.width,
              Flexible(
                child: PrimaryButton(
                  title: confirmText,
                  onPressed: onTap,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget activePrivateKey(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Private Key',
            style: AppFont.semibold16.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            decoration: BoxDecoration(
              color: AppColor.yellowColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImage.pancakeSwap,
                  width: 40.w,
                ),
                16.0.width,
                Flexible(
                  child: Text(
                    'This is the private key for “Main Wallet”. Never disclose this key, anyone who have your private key can fully control your account. Beware of any scam and fraud.',
                    style: AppFont.reguler12.copyWith(
                      color: AppColor.yellowColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.0.height,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Private Key',
              style: AppFont.medium12.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ),
          8.0.height,
          SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                TextFormField(
                  initialValue: controller.privateKeySelected.value,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.w),
                    filled: true,
                    fillColor: Theme.of(context).hintColor.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    disabledBorder: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h, right: 16.w),
                      child: GestureDetector(
                          onTap: () => MethodHelper().handleCopy(
                                data: controller.privateKeySelected.value,
                              ),
                          child: Icon(
                            Icons.copy_rounded,
                            color: AppColor.primaryColor,
                            size: 24.w,
                          ))),
                ),
              ],
            ),
          ),
          24.0.height,
          SecondaryButton(
            title: 'Close',
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget activePhrase(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Recovery Phrase',
            style: AppFont.semibold16.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
            decoration: BoxDecoration(
              color: AppColor.yellowColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImage.empty,
                  width: 40.w,
                ),
                16.0.width,
                Flexible(
                  child: Text(
                    'This is your recovery phrase. Write it down on a paper and keep it in a safe place. You\'ll be asked to re-enter this phrase (in order) on the next step.',
                    style: AppFont.reguler12.copyWith(
                      color: AppColor.yellowColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          DefaultTabController(
            length: 2,
            initialIndex: controller.selectedSheedPharse.value,
            child: TabBar(
              padding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).indicatorColor,
              labelStyle: AppFont.medium14,
              indicatorWeight: 2.h,
              unselectedLabelColor: Theme.of(context).hintColor,
              labelPadding: EdgeInsets.zero,
              onTap: (value) => controller.changeSheedPharse(value),
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.only(bottom: 2.h),
                  text: "Text",
                ),
                Tab(
                  iconMargin: EdgeInsets.only(bottom: 2.h),
                  text: "QRCode",
                ),
              ],
            ),
          ),
          16.0.height,
          controller.selectedSheedPharse.value == 0
              ? Expanded(
                  child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: (2 / 1),
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.all(8.w),
                        children: List.generate(12, (index) {
                          final order = [1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 12];
                          final realIndex = order[index] - 1;
                          return Center(
                            child: Text(
                              '${order[index]}. ${controller.mnemonicSelected.value.split(' ')[realIndex]}',
                              style: AppFont.medium12.copyWith(
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                          );
                        }),
                      )),
                )
              : Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: QrImageView(
                          data: controller.mnemonicSelected.value,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                        ),
                      ),
                    ),
                  ),
                ),
          24.0.height,
          SecondaryButton(
            title: 'Close',
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
