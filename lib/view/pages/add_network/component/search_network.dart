import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/domain/controller/add_network_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';

class SearchNetwork extends StatelessWidget {
  const SearchNetwork({super.key, required this.controller});
  final AddNetworkController controller;
  @override
  Widget build(BuildContext context) {
    Widget cardCoin() {
      return Row(
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
                  child: Image.asset(AppImage.eth)),
            ),
          ),
          8.0.width,
          Expanded(
              child: Text(
            "Ethereum Mainet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark)
          )),
          16.0.width,
          Icon(
            Icons.check_circle_outline_rounded,
            size: 24.w,
            color: AppColor.grayColor,
          )
        ],
      );
    }

    return Expanded(
        child: Column(
      children: [
        SizedBox(
          height: 54.h,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppFont.medium14.copyWith(color: AppColor.textDark),
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
        16.0.height,
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: cardCoin(),
          ),
          itemCount: 10,
        ))
      ],
    ));
  }
}
