import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/chain_network/list_chain_selected.dart';
import 'package:mintsafe_wallet/domain/controller/add_network_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../domain/controller/evm_new_controller.dart';

class SearchNetwork extends StatelessWidget {
  SearchNetwork({super.key, required this.controller});
  final AddNetworkController controller;
  final EvmNewController evm = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardCoin({required ChainNetwork chain}) {
      return GestureDetector(
        onTap: () {
          controller.setChain(ListChainSelected(
            name: chain.name,
            symbol: chain.symbol,
            rpc: chain.rpc,
            chainId: chain.chainId,
            explorer: chain.explorer,
            logo: chain.logo,
            color: chain.color,
            isTestnet: chain.isTestnet,
            walletAddress: evm.selectedAddress.value.address ?? "",
          ));
        },
        child: Row(
          children: [
            SizedBox(
              width: 36.h,
              height: 36.h,
              child: ClipPolygon(
                sides: 6,
                rotate: 0,
                child: Container(
                    padding: EdgeInsets.all(1.h),
                    color: Colors.transparent,
                    child: Image.asset(chain.logo ?? AppImage.eth)),
              ),
            ),
            8.0.width,
            Expanded(
                child: Text(chain.name ?? "",
                    style:
                        AppFont.medium16.copyWith(color: AppColor.textDark))),
            16.0.width,
            evm.listChainSelected.any((element) =>
                    element.chainId!.toLowerCase() ==
                    chain.chainId!.toLowerCase())
                ? Icon(
                    Icons.check_circle_outline_rounded,
                    size: 24.w,
                    color: AppColor.primaryColor,
                  )
                : 24.0.width,
          ],
        ),
      );
    }

    return Expanded(child: Obx(() {
      return Column(
        children: [
          const SearchField(),
          16.0.height,
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: cardCoin(chain: evm.listChain[index]),
            ),
            itemCount: evm.listChain.length,
          ))
        ],
      );
    }));
  }
}
