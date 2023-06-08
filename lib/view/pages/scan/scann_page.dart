import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../../../../config/config.dart';
import '../../../utils/utils.dart';
import 'component/qr_scanner_overlay.dart';

class ScannPage extends StatelessWidget {
  const ScannPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget scan() {
      return Stack(
        children: [
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: true,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
        ],
      );
    }

    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackText,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Scan",
            style: AppFont.medium16,
          ),
        ],
      )),
      body: scan(),
    );
  }
}
