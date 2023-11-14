import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/theme/theme.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../../../../domain/controller/transfer_controller.dart';

class AdvanceSetting extends StatelessWidget {
  AdvanceSetting({super.key});
  final Transfercontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.0.height,
        InputText(
          title: "Gas Price",
          hintText: 'Enter gas price',
          controller: controller.gasPriceController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp('[0-9.,]'),
            ),
          ],
          icon: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'GWEI',
              style: AppFont.reguler12.copyWith(color: AppColor.grayColor),
            ),
          ),
        ),
        16.0.height,
        InputText(
          title: 'Gas Limit',
          hintText: 'Enter gas limit',
          controller: controller.gasLimitController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp('[0-9.,]'),
            ),
          ],
        )
      ],
    );
  }
}
