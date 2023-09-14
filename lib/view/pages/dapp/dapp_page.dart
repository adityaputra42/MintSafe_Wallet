import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/double_extension.dart';

import '../../../config/config.dart';
import '../../widget/widget.dart';

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
                    padding: EdgeInsets.all(0.25.h),
                    color: AppColor.textDark,
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
                  style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: const SearchField(),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: [
                // 16.0.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History",
                      style:
                          AppFont.medium16.copyWith(color: AppColor.textDark),
                    ),
                    Text(
                      "View all",
                      style: AppFont.medium14
                          .copyWith(color: AppColor.primaryColor),
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
                Text(
                  "Recomendation",
                  style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
                  style: AppFont.medium16.copyWith(color: AppColor.textDark),
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
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: ScreenUtil().screenWidth,
              child: Image.asset(
                AppImage.maskHome,
                fit: BoxFit.cover,
              ),
            ),
            body(),
          ],
        ),
      ),
    );
  }
}
