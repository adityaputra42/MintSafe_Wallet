import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';
import '../../../domain/controller/nft_controller.dart';
import '../../../utils/utils.dart';

class AddNft extends StatelessWidget {
  AddNft({super.key});
  final NftController controller = Get.put(NftController());
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                Text("Add NFT",
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
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  24.0.height,
                  Warning(
                      warning:
                          "Make sure you enter the correct information according to the ${evm.selectedChain.value.name} network."),
                  16.0.height,
                  InputText(
                      title: "Contract Address",
                      controller: controller.contractController,
                      onChange: controller.onChangeContract,
                      hintText: "Enter your contract address"),
                  16.0.height,
                  InputText(
                      title: "Token Id",
                      controller: controller.tokenIdController,
                      onChange: controller.onChangeTokenId,
                      hintText: "Enter your token id")
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: PrimaryButton(
          title: "Import",
          loading: controller.isloading.value,
          disable: controller.isAddDisable.value,
          onPressed: () async {
            await controller.fetchNFT(controller.contractController.text,
                int.parse(controller.tokenIdController.text));
          },
          margin: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 32.h),
        ),
      );
    });
  }
}
