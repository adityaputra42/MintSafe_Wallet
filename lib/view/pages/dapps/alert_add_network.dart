import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/data/model/chain_network/list_chain_selected.dart';
import 'package:mintsafe_wallet/domain/controller/add_network_controller.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../widget/widget.dart';

class AlertAddNetwork extends StatelessWidget {
  AlertAddNetwork({
    super.key,
    required this.data,
  });
  final Map<String, dynamic> data;
  final EvmNewController evm = Get.find();
  final AddNetworkController controller =
      Get.isRegistered() ? Get.find() : Get.put(AddNetworkController());
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Row(
            children: [
              24.0.width,
              Expanded(
                child: Text(
                  "Add Network",
                  style: AppFont.medium16.copyWith(
                    color: Theme.of(context).indicatorColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).indicatorColor,
                  size: 24.w,
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget content() {
      return SizedBox(
        width: 900.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColor.primaryColor.withOpacity(0.1)),
              child: Center(
                child: Text(
                  "Allow this site to add network?",
                  style: AppFont.medium14
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
              ),
            ),
            16.0.height,
            itemNetwork(context, "Network Name :", data['object']['chainName']),
            16.0.height,
            itemNetwork(context, "RPC Url :", data['object']['rpcUrls'][0]),
            16.0.height,
            itemNetwork(
                context,
                "Chain ID :",
                int.parse(data['object']['chainId'].toString().substring(2),
                        radix: 16)
                    .toString()),
            16.0.height,
            itemNetwork(context, "Currency symbol :",
                data['object']['nativeCurrency']['symbol']),
            16.0.height,
            itemNetwork(context, "Block explorer URL :",
                data['object']['blockExplorerUrls'][0]),
            32.0.height,
            PrimaryButton(
              onPressed: () {
                controller.setChainNetwork(
                    chainNetwork: ChainNetwork(
                      isTestnet: false,
                      name: data['object']['chainName'],
                      rpc: data['object']['rpcUrls'][0],
                      explorer: data['object']['blockExplorerUrls'][0],
                      explorerApi: data['object']['blockExplorerUrls'][0],
                      symbol: data['object']['nativeCurrency']['symbol'],
                      color: controller.getRandomValue(),
                      logo: 'asset/logo/logo_default.png',
                      chainId: int.parse(
                              data['object']['chainId'].toString().substring(2),
                              radix: 16)
                          .toString(),
                    ),
                    chainSelected: ListChainSelected(
                      isTestnet: false,
                      name: data['object']['chainName'],
                      rpc: data['object']['rpcUrls'][0],
                      walletAddress: evm.selectedAddress.value.address,
                      explorer: data['object']['blockExplorerUrls'][0],
                      explorerApi: data['object']['blockExplorerUrls'][0],
                      symbol: data['object']['nativeCurrency']['symbol'],
                      color: controller.getRandomValue(),
                      logo: 'asset/logo/logo_default.png',
                      chainId: int.parse(
                              data['object']['chainId'].toString().substring(2),
                              radix: 16)
                          .toString(),
                    ));
                evm.changeNetwork(ListChainSelected(
                  isTestnet: false,
                  name: data['object']['chainName'],
                  rpc: data['object']['rpcUrls'][0],
                  walletAddress: evm.selectedAddress.value.address,
                  explorer: data['object']['blockExplorerUrls'][0],
                  explorerApi: data['object']['blockExplorerUrls'][0],
                  symbol: data['object']['nativeCurrency']['symbol'],
                  color: controller.getRandomValue(),
                  logo: 'asset/logo/logo_default.png',
                  chainId: int.parse(
                          data['object']['chainId'].toString().substring(2),
                          radix: 16)
                      .toString(),
                ));
              },
              title: 'Add',
              height: 48,
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      titlePadding: EdgeInsets.zero,
      title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }

  Row itemNetwork(BuildContext context, String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppFont.reguler12.copyWith(
            color: AppColor.grayColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppFont.medium12
                .copyWith(color: Theme.of(context).indicatorColor),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
