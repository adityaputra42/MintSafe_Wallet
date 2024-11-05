import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/pages/scan/scann_page.dart';
import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../domain/controller/evm_new_controller.dart';
import '../../../../utils/utils.dart';
import '../../../widget/widget.dart';

class ImportPrivateKey extends StatelessWidget {
  ImportPrivateKey({super.key});

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
                "Import Private Key",
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
                  Text('Enter Your Private Key',
                      style: AppFont.medium16.copyWith(
                        color: Theme.of(context).indicatorColor,
                      )),
                  12.0.height,
                  Text(
                    'The private key is a secret piece of information that is used to sign transactions and prove ownership of the associated cryptocurrency.',
                    style:
                        AppFont.reguler14.copyWith(color: AppColor.grayColor),
                  ),
                  24.0.height,
                  InputText(
                    title: "Private Key",
                    hintText: 'Enter your private key',
                    textInputAction: TextInputAction.next,
                    controller: evm.importAddressPrivateKeyController,
                    onChange: evm.onchangeImportPrivateKey,
                    maxLine: 6,
                    icon: GestureDetector(
                      onTap: () {
                        Get.to(() => ScannPage(
                              textController:
                                  evm.importAddressPrivateKeyController,
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
                          evm.importAddressPrivateKeyController);
                    },
                    margin: EdgeInsets.only(top: 36.h, bottom: 16.h),
                  ),
                  PrimaryButton(
                    title: 'Import',
                    loading: evm.isLoadingImportPrivateKey.value,
                    disable: evm.disablePrivateKey.value,
                    onPressed: () {
                      evm.importAddressByPrivatekey(
                          evm.importAddressPrivateKeyController.text);
                    },
                    margin: EdgeInsets.only(bottom: 36.w),
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
