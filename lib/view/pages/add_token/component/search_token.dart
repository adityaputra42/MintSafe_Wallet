import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/add_token_controller.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/widget/widget.dart';

import '../../../../config/config.dart';
import '../../../../data/data.dart';

class SearchToken extends StatelessWidget {
  SearchToken({super.key});
  final AddTokenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Widget cardCoin({
      required Token token,
    }) {
      return GestureDetector(
        onTap: () {
          token.selected = !token.selected;
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
                      style:
                          AppFont.medium16.copyWith(color: AppColor.textDark))),
              16.0.width,
              token.selected == true
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
    }

    return Expanded(
      child: Obx(() {
        return Column(
          children: [
            const SearchField(),
            16.0.height,
            Expanded(
                child: controller.tokenList.isEmpty
                    ? const Center(
                        child: Empty(title: "No data token"),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: cardCoin(token: controller.tokenList[index]),
                        ),
                        itemCount: controller.tokenList.length,
                      ))
          ],
        );
      }),
    );
  }
}
