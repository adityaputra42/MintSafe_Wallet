import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/config.dart';
import '../../../../utils/utils.dart';
import '../../../widget/widget.dart';

class ImportPrivateKey extends StatelessWidget {
  const ImportPrivateKey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Import Private Key",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            Text('Enter Your Private Key',
                style: AppFont.medium16.copyWith(color: AppColor.textDark)),
            12.0.height,
            Text(
              'This 12-word phrase allows you to recover your wallet and access to the coins inside.',
              style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
            ),
            24.0.height,
            InputText(
              title: "Private Key",
              hintText: 'Enter your private key',
              textInputAction: TextInputAction.next,
              maxLine: 6,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  8.0.width,
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 32.h,
                  ),
                  24.0.width
                ],
              ),
            ),
            PrimaryButton(
              title: 'Continue',
              disable: true,
              loading: false,
              onPressed: () {},
              margin: EdgeInsets.only(top: 24.h, bottom: 36.w),
            ),
          ],
        ),
      ),
    );
  }
}
