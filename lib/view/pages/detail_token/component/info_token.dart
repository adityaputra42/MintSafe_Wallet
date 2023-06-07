import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/extension/extension.dart';

class InfoToken extends StatelessWidget {
  const InfoToken({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardLink({Function()? ontap, required String image}) {
      return GestureDetector(
        child: Container(
          width: 48.w,
          height: 48.w,
          padding: EdgeInsets.all(10.h),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffD0F0FF),
          ),
          child: Image.asset(image),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Detial Token",
          style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
        ),
        12.0.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "Token name",
                style: AppFont.reguler14.copyWith(color: AppColor.darkerGray),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "ETH",
                style: AppFont.medium14,
              ),
            )
          ],
        ),
        8.0.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "Project name",
                style: AppFont.reguler14.copyWith(color: AppColor.darkerGray),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "Ethereum mainet",
                style: AppFont.medium14,
              ),
            )
          ],
        ),
        8.0.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "Total circulation",
                style: AppFont.reguler14.copyWith(color: AppColor.darkerGray),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                "Detial Token",
                style: AppFont.medium14,
              ),
            )
          ],
        ),
        24.0.height,
        Text(
          "Description",
          style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
        ),
        8.0.height,
        Text(
          "Binance Coin is a token issued by Binance, referred to as BNB, which is a decentralized blockchain digital asset based on Ethereum. The total amount of issuance is constant at 200 million.",
          style: AppFont.reguler14.copyWith(
            color: AppColor.darkerGray,
          ),
          textAlign: TextAlign.justify,
        ),
        16.0.height,
        Row(
          children: [
            cardLink(image: AppImage.twitter),
            16.0.width,
            cardLink(image: AppImage.telegram),
            16.0.width,
            cardLink(image: AppImage.medium),
            16.0.width,
            cardLink(image: AppImage.website),
            16.0.width,
            cardLink(image: AppImage.explorer),
          ],
        )
      ],
    );
  }
}
