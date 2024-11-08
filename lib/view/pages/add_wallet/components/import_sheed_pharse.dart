import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../utils/utils.dart';
import '../../../widget/widget.dart';
import '../../scan/scann_page.dart';

class ImportSheedPharse extends StatelessWidget {
  ImportSheedPharse({super.key});
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
                "Import Sheed Pharse",
                style: AppFont.medium16.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
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
          Obx(() {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.0.height,
                  Text(
                    'Enter Your Secret Recovery Phrase',
                    style: AppFont.medium16.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                  8.0.height,
                  Text(
                    "This 12-word phrase allows you to recover your wallet and access to the coins inside.",
                    style:
                        AppFont.reguler14.copyWith(color: AppColor.grayColor),
                  ),
                  24.0.height,
                  InputText(
                    title: "Sheed Pharse",
                    hintText: 'Enter your sheed pharse',
                    textInputAction: TextInputAction.done,
                    controller: evm.importAddressMnemonicController,
                    maxLine: 6,
                    onChange: evm.onchangeImportMnemonic,
                    icon: GestureDetector(
                      onTap: () {
                        Get.to(() => ScannPage(
                              textController:
                                  evm.importAddressMnemonicController,
                            ));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          8.0.width,
                          Icon(
                            Icons.qr_code_scanner_rounded,
                            size: 32.h,
                          ),
                          24.0.width
                        ],
                      ),
                    ),
                  ),
                  SecondaryButton(
                    title: 'Paste Sheed Pharse',
                    onPressed: () {
                      MethodHelper().pasteFromClipboard(
                          evm.importAddressMnemonicController);
                    },
                    margin: EdgeInsets.only(top: 36.h, bottom: 16.h),
                  ),
                  PrimaryButton(
                    title: 'Continue',
                    loading: evm.isLoadingImportMnemonic.value,
                    disable: evm.disableMnemonic.value,
                    onPressed: () {
                      evm.importAddressByMnemonic(
                          evm.importAddressMnemonicController.text);
                    },
                    margin: EdgeInsets.only(bottom: 36.h),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
