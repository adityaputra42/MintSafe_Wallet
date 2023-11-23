import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/domain/controller/transfer_controller.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../../../config/config.dart';
import '../../../domain/controller/evm_new_controller.dart';
import '../../../domain/controller/import_waller_controller.dart';
import '../../../domain/controller/nft_controller.dart';
import '../transfer/choose_receiver.dart';
import 'component/qr_scanner_overlay.dart';

enum ScanType { address, addressNft, privateKey, mnemonic, walletConnect }

class ScannPage extends StatelessWidget {
  final ScanType? scanType;
  final AssetType? asset;
  final TextEditingController? textController;
  final SelectedToken? token;
  const ScannPage({
    Key? key,
    this.scanType,
    this.asset,
    this.textController,
    this.token,
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
                if (scanType == ScanType.address && textController == null) {
                  Transfercontroller controller = Get.isRegistered()
                      ? Get.find()
                      : Get.put(Transfercontroller());
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                  } else {
                    final String code = barcode.rawValue!;
                    final address = code.substring(code.indexOf(":") + 1);

                    if (isValidEthereumAddress(address)) {
                      controller.addressController.text =
                          code.substring(code.indexOf(":") + 1);
                      controller.isValidAddressSent.value = true;
                      controller.checkButtonNext();
                      Navigator.pop(context, code);
                      Get.to(() => ChooseReceiver(
                            token: asset == AssetType.token ? token : null,
                            assetType: asset ?? AssetType.coin,
                          ));
                    } else {
                      controller.isValidAddressSent.value = false;

                      // Navigator.pop(context);
                    }
                  }
                } else if (scanType == ScanType.addressNft &&
                    textController == null) {
                  NftController controller = Get.isRegistered()
                      ? Get.find()
                      : Get.put(NftController());
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                  } else {
                    final String code = barcode.rawValue!;
                    final address = code.substring(code.indexOf(":") + 1);

                    if (isValidEthereumAddress(address)) {
                      controller.addressController.text =
                          code.substring(code.indexOf(":") + 1);
                      controller.isValidAddressSent.value = true;
                      controller.checkButtonNext();
                      Navigator.pop(context, code);
                    } else {
                      controller.isValidAddressSent.value = false;

                      Navigator.pop(context);
                    }
                  }
                } else if (scanType == ScanType.privateKey &&
                    textController == null) {
                  EvmNewController evm = Get.find();
                  evm.importAddressPrivateKeyController.text =
                      barcode.rawValue!;
                  Navigator.pop(context);
                } else if (scanType == ScanType.walletConnect &&
                    textController == null) {
                  Navigator.pop(context, barcode.rawValue);
                } else if (scanType == ScanType.mnemonic &&
                    textController == null) {
                  ImportWalletController controller = Get.find();
                  controller.sheedPharse.text = barcode.rawValue!;
                  Navigator.pop(context);
                } else {
                  textController?.text = barcode.rawValue!;
                  Navigator.pop(context);
                }
              }
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgLight,
      body: scan(),
    );
  }
}
