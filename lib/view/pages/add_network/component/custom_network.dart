import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';
import 'package:mintsafe_wallet/view/widget/warning.dart';

import '../../../../domain/controller/add_network_controller.dart';
import '../../../widget/widget.dart';

class CustomNetwork extends StatelessWidget {
  const CustomNetwork({super.key, required this.controller});
  final AddNetworkController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Warning(
                    warning:
                        "A malicious network provider can lie about the state of the blockchain and record your network activity. Only add custom networks you trust."),
                16.0.height,
                InputText(
                  title: "Network name",
                  hintText: "Enter netweok name",
                  controller: controller.networkNameController,
                ),
                16.0.height,
                InputText(
                  title: "New RPC URL",
                  hintText: "Enter new RPC URL",
                  controller: controller.rpcUrlController,
                ),
                16.0.height,
                InputText(
                  title: "Chain ID",
                  hintText: "Enter chain id",
                  controller: controller.chainIdController,
                ),
                16.0.height,
                InputText(
                  title: "Currency symbol",
                  hintText: "Enter currency symbol",
                  controller: controller.currencySymbolController,
                ),
                16.0.height,
                InputText(
                  title: "Block explorer URL (Optional)",
                  hintText: "Enter block explorer url",
                  controller: controller.blockExplorerController,
                ),
              ],
            ),
          ),
          PrimaryButton(
            title: "Confirm",
            onPressed: () {},
            margin: EdgeInsets.only(bottom: 24.h, top: 8.h),
          ),
        ],
      ),
    );
  }
}
