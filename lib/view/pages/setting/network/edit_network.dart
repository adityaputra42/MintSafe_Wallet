import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/domain/controller/network_setting_controller.dart';
import 'package:mintsafe_wallet/view/widget/input_text.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:mintsafe_wallet/view/widget/secondary_button.dart';

import '../../../../config/config.dart';
import '../../../../utils/utils.dart';

class EditNetwork extends StatefulWidget {
  const EditNetwork({super.key, required this.chain});
  final ChainNetwork chain;

  @override
  State<EditNetwork> createState() => _EditNetworkState();
}

class _EditNetworkState extends State<EditNetwork> {
  late final NetworkSettingController controller;

  @override
  void initState() {
    controller = Get.put(NetworkSettingController(network: widget.chain));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                  Text("${widget.chain.name}",
                      style: AppFont.medium16
                          .copyWith(color: Theme.of(context).indicatorColor)),
                ],
              )),
          body: Stack(children: [
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InputText(
                      enable: false,
                      title: 'Network Name',
                      hintText: 'Enter network name',
                      controller: controller.nameController,
                    ),
                    16.0.height,
                    InputText(
                      enable: controller.rpcEnable.value,
                      autoFocus: true,
                      title: 'URL RPC',
                      hintText: 'Enter url rpc',
                      controller: controller.rpcController,
                    ),
                    16.0.height,
                    InputText(
                      enable: false,
                      title: 'Chain Id',
                      hintText: 'Enter chain id',
                      controller: controller.chainIdController,
                    ),
                    16.0.height,
                    InputText(
                      enable: false,
                      title: 'Network Symbol',
                      hintText: 'Enter network symbol',
                      controller: controller.symbolController,
                    ),
                    16.0.height,
                    InputText(
                      enable: false,
                      title: 'URL Block Explorer',
                      hintText: 'Enter url block exploler',
                      controller: controller.explorerController,
                    ),
                    16.0.height,
                  ],
                ),
              ),
            )
          ]),
          bottomNavigationBar: controller.rpcEnable.value
              ? PrimaryButton(
                  title: "Save",
                  loading: controller.isLoading.value,
                  onPressed: () {
                    controller.updateRpc();
                  },
                  margin: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                )
              : SecondaryButton(
                  title: "Edit RPC",
                  onPressed: () {
                    controller.changeEnable(true);
                  },
                  margin: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                ));
    });
  }
}
