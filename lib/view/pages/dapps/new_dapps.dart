// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:eth_sig_util/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/dapps/alert_add_network.dart';
import 'package:mintsafe_wallet/view/pages/dapps/alert_switch_network.dart';
import 'package:web3_provider/web3_provider.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

import '../../../config/config.dart';
import '../../../domain/controller/controller.dart';
import 'js_bridge_bean.dart';
import 'payment_sheet_page.dart';

class DappsWeb3 extends StatefulWidget {
  final String initialUrl;

  const DappsWeb3({super.key, required this.initialUrl});
  @override
  State<DappsWeb3> createState() => _DappsWeb3State();
}

class _DappsWeb3State extends State<DappsWeb3> {
  DappsController web3 = Get.find();
  BottomNavBarController controller = Get.find();

  String urlValidator(String url) {
    String value = '';
    if (MethodHelper().isURL(url)) {
      value = url;
    } else {
      value = "https://www.google.com/search?q=$url";
    }
    log(value.toString());
    return value;
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      // userAgent:
      //     "Mozilla/5.0 (Linux; Android 4.4.4; SAMSUNG-SM-N900A Build/tt) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/33.0.0.0 Mobile Safari/537.36",
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
      domStorageEnabled: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  _signTransaction({
    required BridgeParams bridge,
    required VoidCallback cancel,
    required Function(String idHash) success,
    String host = "",
    String favicon = "",
  }) async {
    final credentials =
        EthPrivateKey.fromHex(web3.evm.selectedPrivateKey.value);
    final sender = EthereumAddress.fromHex(bridge.from ?? '');
    final signto = EthereumAddress.fromHex(bridge.to ?? '');
    final input = hexToBytes(bridge.data ?? '');
    String? price = (bridge.gasPrice == null)
        ? (await web3.web3client!.getGasPrice()).toString()
        : bridge.gasPrice;
    // String? price = bridge.gasPrice;

    int? maxGas;

    try {
      maxGas = (bridge.gas ??
          await web3.web3client!.estimateGas(
            sender: sender,
            to: signto,
            data: input,
          )) as int?;
    } catch (e) {
      RPCError err = e as RPCError;
      log(err.toString());
      cancel.call();
      return;
    }
    var newPrice = price!.replaceAll(RegExp(r'[^0-9]'), '');
    log("max gas : ${maxGas.toString()} price : $newPrice");
    // String fee =
    FormatterBalance.configFeeValue(
        beanValue: maxGas.toString(), offsetValue: newPrice.toString());
    _showModalConfirm(
        from: web3.evm.selectedAddress.value.address ?? "",
        to: bridge.to ?? '',
        host: host,
        favicon: favicon,
        value: bridge.value ?? BigInt.zero,
        // fee: fee,
        fee: (double.parse(maxGas.toString()) / math.pow(10, 9).toDouble())
            .toString(),
        confirm: () async {
          try {
            String result = await web3.web3client!.sendTransaction(
              credentials,
              Transaction(
                  to: signto,
                  value: EtherAmount.inWei(bridge.value ?? BigInt.zero),
                  gasPrice: null,
                  maxGas: maxGas,
                  data: input),
              chainId: int.parse(web3.evm.selectedChain.value.chainId!),
              fetchChainIdFromNetworkId: false,
            );

            if (result.isNotEmpty) {
              web3.evm.getEthBalancePeriodic();
              web3.evm.getBalance();
            }
            success.call(result);
          } catch (e) {
            if (e.toString().contains('-32000')) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("gasLow"),
              ));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.toString()),
              ));
            }
          }
        },
        cancel: () {
          cancel.call();
        });
  }

  _showModalConfirm({
    required String from,
    required String to,
    required BigInt value,
    required String fee,
    required VoidCallback confirm,
    required VoidCallback cancel,
    String? host = "",
    bool isSignMsg = false,
    String? msg = "",
    String? favicon = "",
  }) {
    Get.dialog(
      PaymentDialog(
        favicon: favicon,
        isSignMsg: isSignMsg,
        host: host,
        msg: msg ?? "",
        estimateGas: fee,
        datas: PaymentDialog.getTransStyleList(
          from: from,
          to: to,
          remark: '',
          fee: "$fee ${web3.evm..selectedChain.value.symbol}",
        ),
        amount:
            "${value.tokenString(18)} ${web3.evm..selectedChain.value.symbol}",
        nextAction: () async {
          confirm.call();
        },
        cancelAction: () {
          cancel.call();
        },
      ),
    );
  }

  _showModalAddChain({
    required String from,
    required String to,
    required BigInt value,
    required String fee,
    required VoidCallback confirm,
    required VoidCallback cancel,
  }) {
    Get.dialog(PaymentDialog(
      datas: PaymentDialog.getTransStyleList(
        from: from,
        to: to,
        remark: '',
        fee: "$fee ${web3.evm..selectedChain.value.symbol}",
      ),
      amount:
          "${value.tokenString(18)} ${web3.evm..selectedChain.value.symbol}",
      nextAction: () async {
        confirm.call();
      },
      cancelAction: () {
        cancel.call();
      },
    ));
  }

  _showModalSignTypedTx({
    required String from,
    required String to,
    required BigInt value,
    required String fee,
    required VoidCallback confirm,
    required VoidCallback cancel,
  }) {
    Get.dialog(PaymentDialog(
      datas: PaymentDialog.getTransStyleList(
        from: from,
        to: to,
        remark: '',
        fee: "$fee ${web3.evm..selectedChain.value.symbol}",
      ),
      amount:
          "${value.tokenString(18)} ${web3.evm..selectedChain.value.symbol}",
      nextAction: () async {
        confirm.call();
      },
      cancelAction: () {
        cancel.call();
      },
    ));
  }

  String customFunctionInject({
    required int chainId,
    required String rpcUrl,
    required String walletAddress,
    bool? isDebug = true,
  }) {
    return """
         {
            ethereum:{
              chainId: ${web3.evm..selectedChain.value.chainId!},
              rpcUrl: "$rpcUrl",
              address: "$walletAddress",
              isDebug: $isDebug  
            }
         }
        """;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canBack = await web3.webController.canGoBack();
        if (canBack) {
          web3.webController.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: WidgetHelper.appBar(
            context: context,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.initialUrl.clear();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Theme.of(context).indicatorColor,
                    size: 24.h,
                  ),
                ),
                16.0.width,
                Expanded(
                  child: Text(
                    web3.title.value,
                    style: AppFont.medium14
                        .copyWith(color: Theme.of(context).indicatorColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
        body: Obx(() {
          return LoadingOverlay(
            isLoading: web3.evm.isLoadingNetwork.value,
            color: Colors.black,
            opacity: 0.3,
            progressIndicator: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(
                    radius: 20.r,
                    color: Theme.of(context).primaryColor,
                  ),
                  12.0.height,
                  Text(
                    "Conneting to ${web3.evm..selectedChain.value.name}",
                    style: AppFont.medium16.copyWith(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
            ),
            child: InAppWebViewEIP1193(
              onWebViewCreated: (controller) {
                web3.initWebController(controller);
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) async {
                web3.initWebController(controller);

                final title = await controller.getTitle();
                final image = await web3.screenshotTab();

                final aa = web3
                    .selectedTab()
                    .copyWith(url: url.toString(), name: title, image: image);

                await web3.onChangeEventTab(aa);

                await web3.screenshotTab();
              },
              onTitleChanged: (controller, title) async {
                // final url =
                await web3.webController.getUrl();

                setState(() {
                  web3.changedTitle(title ?? "Dapps");
                });
              },
              chainId: int.parse(web3.evm.selectedChain.value.chainId!),
              rpcUrl: web3.evm.selectedChain.value.rpc,
              walletAddress: web3.evm.selectedAddress.value.address,
              signCallback: (params, eip1193, controller) async {
                final id = params["id"];
                switch (eip1193) {
                  case EIP1193.requestAccounts:
                    log(web3.evm.selectedAddress.value.address!);
                    log(id.toString());
                    controller!.setAddress(
                      web3.evm.selectedAddress.value.address!,
                      id,
                    );
                    break;
                  case EIP1193.signTransaction:
                    Map<String, dynamic> object = params["object"];

                    final uri = await controller?.getUrl();
                    final favicon = await controller?.requestImageRef();
                    final host = "${uri?.host}";

                    BridgeParams bridge = BridgeParams.fromJson(object);
                    _signTransaction(
                        bridge: bridge,
                        host: host,
                        favicon: favicon != null ? favicon.url.toString() : "",
                        cancel: () {
                          controller?.cancel(id);
                        },
                        success: (idHash) {
                          controller?.sendResult(idHash, id);
                        });

                    break;
                  case EIP1193.signMessage:
                  case EIP1193.signPersonalMessage:
                    Map<String, dynamic> object = params["object"];
                    String data = object["data"];
                    log("signTx personal $object");
                    log(params.toString());
                    _showModalConfirm(
                        from: web3.evm.selectedAddress.value.address!,
                        to: '',
                        value: BigInt.zero,
                        fee: '0',
                        isSignMsg: true,
                        msg: data,
                        confirm: () async {
                          final credentials = EthPrivateKey.fromHex(
                              web3.evm.selectedPrivateKey.value);
                          Uint8List message = credentials
                              .signPersonalMessageToUint8List(hexToBytes(data));

                          String result = hex.encode(message);
                          log("Result sign : $result");
                          controller?.sendResult(result, id);
                        },
                        cancel: () {
                          controller?.cancel(id);
                        });
                    break;
                  case EIP1193.signTypedMessage:
                    Map<String, dynamic> object = params["object"];
                    final data = object['data'];

                    log("signTx ${object['data']}");

                    _showModalConfirm(
                        from: web3.evm.selectedAddress.value.address!,
                        to: '',
                        value: BigInt.zero,
                        fee: '0',
                        confirm: () async {
                          final credentials = EthPrivateKey.fromHex(
                              web3.evm.selectedPrivateKey.value);

                          var bytes = utf8.encode(data);

                          Uint8List message = credentials
                              .signToUint8List(Uint8List.fromList(bytes));
                          String result = hex.encode(message);
                          log("result : 0x$result");
                          controller?.sendResult(result, id);
                        },
                        cancel: () {
                          controller?.cancel(id);
                        });
                    break;
                  case EIP1193.addEthereumChain:
                    // log(params.toString());
                    if (params['name'] == 'addEthereumChain') {
                      final data = jsonEncode(params);
                      final finalData = jsonDecode(data);

                      if (web3.evm.listChain.any((element) =>
                          element.chainId ==
                          int.parse(
                                  finalData['object']['chainId']
                                      .toString()
                                      .substring(2),
                                  radix: 16)
                              .toString())) {
                        Get.dialog(AlertSwitchNetwork(data: finalData));
                      } else {
                        Get.dialog(AlertAddNetwork(data: finalData));
                      }
                    }
                    break;
                }
              },
              initialUrlRequest: URLRequest(
                url: Uri.parse(
                  urlValidator(widget.initialUrl),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<dynamic> sheetSetting(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.r),
          ),
        ),
        builder: (context) {
          return Builder(builder: (context) {
            return StatefulBuilder(builder: (context, setStaxte) {
              return Container(
                margin: EdgeInsets.only(
                  top: 16.h,
                  left: 32.w,
                  right: 32.w,
                  bottom: 54.h,
                ),
                height: MediaQuery.of(context).size.height / 6,
                child: Column(
                  children: [
                    Text(web3.title.value,
                        style: AppFont.semibold16
                            .copyWith(color: Theme.of(context).indicatorColor)),
                    20.0.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            MethodHelper().handleCopy(
                              data: web3.url.value,
                            );
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.copy_outlined,
                                color: Theme.of(context).indicatorColor,
                                size: 30,
                              ),
                              5.0.height,
                              Text("Copy url",
                                  style: AppFont.medium14.copyWith(
                                      color: Theme.of(context).indicatorColor)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            web3.webController.reload();
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.refresh_outlined,
                                color: Theme.of(context).indicatorColor,
                                size: 30,
                              ),
                              5.0.height,
                              Text("Refresh",
                                  style: AppFont.medium14.copyWith(
                                      color: Theme.of(context).indicatorColor)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            web3.webController.clearCache();
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.cleaning_services_outlined,
                                color: Theme.of(context).indicatorColor,
                                size: 30,
                              ),
                              5.0.height,
                              Text("Clear cache",
                                  style: AppFont.medium14.copyWith(
                                      color: Theme.of(context).indicatorColor)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.help_outline_rounded,
                              color: Theme.of(context).indicatorColor,
                              size: 30,
                            ),
                            5.0.height,
                            Text("Help",
                                style: AppFont.medium14.copyWith(
                                    color: Theme.of(context).indicatorColor)),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Text(
                        "Close",
                        style: AppFont.semibold16
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              );
            });
          });
        });
  }
}
