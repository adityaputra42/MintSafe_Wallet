import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/domain/controller/add_network_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

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
              child: Text("Ethereum Mainet",
                  style: AppFont.medium16.copyWith(color: AppColor.textDark))),
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
        const SearchField(),
        16.0.height,
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: cardCoin(),
          ),
          itemCount: 6,
        ))
      ],
    ));
  }
}
