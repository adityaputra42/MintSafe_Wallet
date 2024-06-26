import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/add_token_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';
import '../../../../data/model/token/selected_token.dart';

class SearchToken extends StatelessWidget {
  SearchToken({super.key});
  final AddTokenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return Column(
          children: [
            SearchField(
              onChange: (key) {
                controller.evm.searchTokenList(key);
              },
            ),
            16.0.height,
            Expanded(
                child: controller.evm.searchToken.isEmpty
                    ? const Center(
                        child: Empty(title: "No data token"),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: cardCoin(
                              token: controller.evm.searchToken[index],
                              context: context),
                        ),
                        itemCount: controller.evm.searchToken.length,
                      ))
          ],
        );
      }),
    );
  }

  Widget cardCoin({
    required Token token,
    required BuildContext context,
  }) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.setToken(SelectedToken(
              name: token.name,
              contractAddress: token.contractAddress,
              symbol: token.symbol,
              walletAddress: controller.evm.selectedAddress.value.address,
              selected: true,
              decimal: token.decimal,
              balance: token.balance,
              logo: token.logo,
              chainId: token.chainId));
        },
        child: SizedBox(
          child: Row(
            children: [
              SizedBox(
                width: 42.h,
                height: 42.h,
                child: ClipPolygon(
                  sides: 6,
                  rotate: 0,
                  child: Container(
                      padding: EdgeInsets.all(1.h),
                      color: Colors.transparent,
                      child: Image.asset(token.logo ?? AppImage.eth)),
                ),
              ),
              8.0.width,
              Expanded(
                  child: Text(token.name ?? "",
                      style: AppFont.medium16
                          .copyWith(color: Theme.of(context).indicatorColor))),
              16.0.width,
              controller.evm.tokenSelected.any((element) =>
                      element.contractAddress!.toLowerCase() ==
                      token.contractAddress!.toLowerCase())
                  ? Icon(
                      Icons.check_circle_outline_rounded,
                      size: 24.w,
                      color: AppColor.primaryColor,
                    )
                  : 24.0.width,
            ],
          ),
        ),
      );
    });
  }
}
