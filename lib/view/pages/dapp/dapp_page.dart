import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';

import '../../../config/config.dart';

class DAppPage extends StatelessWidget {
  const DAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardDefi(String image, String title, String subtitle,
        {bool isHistory = false}) {
      return SizedBox(
        // width: MediaQuery.of(context).size.width * 0.425,
        child: Row(
          children: [
            SizedBox(
              width: 48.h,
              height: 48.h,
              child: ClipPolygon(
                sides: 6,
                rotate: 0,
                child: Container(
                    padding: EdgeInsets.all(1.h),
                    color: Colors.white,
                    child: Image.asset(
                      image,
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
                  title,
                  style: AppFont.medium16,
                ),
                Text(
                  subtitle,
                  style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )),
            isHistory
                ? Row(
                    children: [
                      8.0.width,
                      Icon(
                        Icons.delete_outline_rounded,
                        size: 24.h,
                        color: AppColor.redColor,
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      );
    }

    Widget body() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: [
          16.0.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "History",
                style: AppFont.medium16,
              ), Text(
                "View all",
                style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
              ),
            ],
          ),
          16.0.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardDefi(AppImage.pancakeSwap, "PancakeSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity",
                  isHistory: true),
              16.0.height,
              cardDefi(AppImage.uniswap, "UniSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity",
                  isHistory: true),
              16.0.height,
              cardDefi(AppImage.opensea, "OpenSea",
                  "Trade, earn and win crypto in decentralize app and more oportunity",
                  isHistory: true),
              16.0.height,
              cardDefi(AppImage.chainlink, "ChainLink",
                  "Trade, earn and win crypto in decentralize app and more oportunity",
                  isHistory: true),
              16.0.height,
            ],
          ),
          // Text(
          //   "Top",
          //   style: AppFont.medium16,
          // ),
          // 16.0.height,
          //  Wrap(
          //   crossAxisAlignment: WrapCrossAlignment.center,
          //   runAlignment: WrapAlignment.center,
          //   alignment: WrapAlignment.center,
          //   spacing: 16.h,
          //   runSpacing: 8.h,
          //   direction: Axis.horizontal,
          //   children: [

          //     cardDefi(AppImage.pancakeSwap, "PancakeSwap",
          //         "Trade, earn and win crypto"),

          //     cardDefi(AppImage.uniswap, "UniSwap",
          //         "Trade, earn and win crypto"),

          //     cardDefi(AppImage.opensea, "OpenSea",
          //         "Trade, earn and win crypto"),

          //     cardDefi(AppImage.quickswap, "QuickSwap",
          //         "Trade, earn and win crypto"),

          //     cardDefi(AppImage.ens, "Ens ETH",
          //         "Trade, earn and win crypto"),

          //     cardDefi(AppImage.chainlink, "ChainLink",
          //         "Trade, earn and win crypto")
          //   ]),
          Text(
            "Recomendation",
            style: AppFont.medium16,
          ),
          16.0.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardDefi(AppImage.pancakeSwap, "PancakeSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.uniswap, "UniSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.opensea, "OpenSea",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.quickswap, "QuickSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.ens, "Ens ETH",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.chainlink, "ChainLink",
                  "Trade, earn and win crypto in decentralize app and more oportunity")
            ],
          ),
          24.0.height,
          Text(
            "Top",
            style: AppFont.medium16,
          ),
          16.0.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardDefi(AppImage.pancakeSwap, "PancakeSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.uniswap, "UniSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.opensea, "OpenSea",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.quickswap, "QuickSwap",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.ens, "Ens ETH",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
              cardDefi(AppImage.chainlink, "ChainLink",
                  "Trade, earn and win crypto in decentralize app and more oportunity"),
              16.0.height,
            ],
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgLight,
      appBar: WidgetHelper.appBar(
        title: SizedBox(
          height: 54.h,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppFont.medium14,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  size: 20.w,
                ),
               
                hintText: "Search",
                hintStyle: AppFont.reguler14.copyWith(
                    fontWeight: FontWeight.w300, color: AppColor.grayColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: AppColor.grayColor, width: 0.5
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: AppColor.grayColor, width: 0.5
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: AppColor.primaryColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w)),
          ),
        ),
      ),
      body: body(),
    );
  }
}
