import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../domain/controller/controller.dart';
import '../../../widget/widget.dart';

class CustomToken extends StatelessWidget {
  CustomToken({super.key});
  final AddTokenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Warning(
                        warning:
                            "Make sure you enter the correct information according to the ${controller.evm.selectedChain.value.name} network."),
                    16.0.height,
                    InputText(
                      title: "Name",
                      hintText: "Enter token name",
                      onChange: controller.onChangeName,
                      controller: controller.nameController,
                    ),
                    16.0.height,
                    InputText(
                      title: "Token Address",
                      hintText: "Enter token address",
                      onChange: controller.onChangeTokenAddress,
                      controller: controller.tokenAddressController,
                    ),
                    16.0.height,
                    InputText(
                      title: "Token Symbol",
                      hintText: "Enter token symbol",
                      onChange: controller.onChangeTokenSymbol,
                      controller: controller.tokenSymbolController,
                    ),
                    16.0.height,
                    InputText(
                      title: "Decimal",
                      hintText: "Enter decimal",
                      onChange: controller.onChangeDecimal,
                      controller: controller.decimalController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                PrimaryButton(
                  title: "Confirm",
                  disable: controller.disableImportButton.value,
                  onPressed: () {
                    controller.setCustomToken();
                  },
                  margin: EdgeInsets.fromLTRB(0, 16.h, 0, 32.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
