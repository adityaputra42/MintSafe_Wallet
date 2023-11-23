import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../data/data.dart';
import '../../../domain/controller/bottom_navbar_controller.dart';
import '../../../domain/controller/browser_controller.dart';
import '../../../domain/controller/dapp_controller.dart';
import '../../widget/widget.dart';
import 'new_dapps.dart';

class SearchDapps extends StatelessWidget {
  SearchDapps({super.key});

  final BottomNavBarController controller = Get.put(BottomNavBarController());
  final BrowserController browserController = Get.put(BrowserController());
  final DappsController web3 = Get.put(DappsController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, //,
      child: Obx(() {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Stack(
              children: [
                SizedBox(
                  width: ScreenUtil().screenWidth,
                  child: Image.asset(
                    AppImage.maskHome,
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(child: body(context)),
              ],
            ));
      }),
    );
  }

  Widget cardDefi({
    required BuildContext context,
    String? image,
    String? title,
    String? subtitle,
    String? url,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DappsWeb3(
              initialUrl: url!,
            ));
      },
      child: SizedBox(
        child: Row(
          children: [
            SizedBox(
              width: 48.h,
              height: 48.h,
              child: ClipPolygon(
                sides: 6,
                rotate: 0,
                child: Container(
                    padding: EdgeInsets.all(0.25.h),
                    color: AppColor.textDark,
                    child: Image.asset(
                      image!,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            8.0.width,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                Text(
                  subtitle!,
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
          child: SearchField(
            controller: controller.initialUrl,
            onChange: (value) => controller.setSearch(value),
            onEditingComplete: () {
              log(controller.initialUrl.text);
              if (controller.initialUrl.text.isNotEmpty) {
                Get.to(() => DappsWeb3(initialUrl: controller.initialUrl.text));
              }
              controller.initialUrl.clear();
            },
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                browserController.dappsHistory.isEmpty
                    ? const SizedBox()
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "History",
                                style: AppFont.medium16.copyWith(
                                    color: Theme.of(context).indicatorColor),
                              ),
                              Text(
                                "View all",
                                style: AppFont.medium14
                                    .copyWith(color: AppColor.primaryColor),
                              ),
                            ],
                          ),
                          Column(
                            children: List.generate(
                                browserController.dappsHistory.length < 5
                                    ? browserController.dappsHistory.length
                                    : 5, (index) {
                              final item = browserController
                                  .dappsHistory.reversed
                                  .toList()[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DappsWeb3(
                                        initialUrl: item.url!,
                                      ));
                                },
                                child: cardHitoryBrowser(item, context),
                              );
                            }),
                          ),
                          16.0.height,
                        ],
                      ),
                Text(
                  "Recomendation",
                  style: AppFont.medium16
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                16.0.height,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cardDefi(
                        context: context,
                        image: AppImage.pancakeSwap,
                        title: "PancakeSwap",
                        subtitle:
                            "Trade, earn and win crypto in decentralize app and more oportunity",
                        url: 'https://pancakeswap.finance/'),
                    16.0.height,
                    cardDefi(
                        context: context,
                        image: AppImage.uniswap,
                        title: "Uniswap",
                        subtitle:
                            "Trade, earn and win crypto in decentralize app and more oportunity",
                        url: 'https://app.uniswap.org/'),
                    16.0.height,
                    cardDefi(
                        context: context,
                        image: AppImage.opensea,
                        title: "OpenSea",
                        subtitle:
                            "Trade, earn and win crypto in decentralize app and more oportunity",
                        url: 'https://opensea.io/'),
                    16.0.height,
                    cardDefi(
                        context: context,
                        image: AppImage.quickswap,
                        title: "QuickSwqp",
                        subtitle:
                            "Trade, earn and win crypto in decentralize app and more oportunity",
                        url: 'https://quickswap.exchange/#/'),
                    16.0.height,
                    cardDefi(
                        context: context,
                        image: AppImage.ens,
                        title: "Ens ETH",
                        subtitle:
                            "Trade, earn and win crypto in decentralize app and more oportunity",
                        url: 'https://ens.domains/'),
                    16.0.height,
                    cardDefi(
                        context: context,
                        image: AppImage.chainlink,
                        title: "ChainLink",
                        subtitle:
                            "Trade, earn and win crypto in decentralize app and more oportunity",
                        url: 'https://chain.link/'),
                    16.0.height,
                  ],
                ),
                16.0.height,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding cardHitoryBrowser(DappsHistory item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            Icons.public,
            size: 24.w,
          ),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title ?? "",
                  maxLines: 1,
                  style: AppFont.medium12
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
                Text(
                  item.url ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.light10
                      .copyWith(color: Theme.of(context).indicatorColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              browserController.deleteDappsHistory(item.id!);
            },
            child: Icon(
              Icons.delete,
              color: AppColor.redColor,
              size: 20.w,
            ),
          )
        ],
      ),
    );
  }
}
