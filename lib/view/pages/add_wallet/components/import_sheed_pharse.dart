import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../config/config.dart';
import '../../../../utils/utils.dart';
import '../../../widget/widget.dart';

class ImportSheedPharse extends StatelessWidget {
  const ImportSheedPharse({super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardPniomoni({required int number}) {
      return SizedBox(
        height: 42.h,
        width: MediaQuery.of(context).size.width * 0.426,
        child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppFont.medium14.copyWith(color: AppColor.textDark),
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 0, 12.h),
                child: Text(
                  number.toString(),
                  style: AppFont.medium14.copyWith(color: AppColor.textDark),
                ),
              ),
              contentPadding: EdgeInsets.fromLTRB(0, 12.h, 16.w, 12.h),
              fillColor: AppColor.cardDark,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            )),
      );
    }

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
            "Import Sheed Pharse",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.0.height,
              Text(
                'Enter Your Secret Recovery Phrase',
                style: AppFont.medium16.copyWith(color: AppColor.textDark),
              ),
              8.0.height,
              Text(
                "This 12-word phrase allows you to recover your wallet and access to the coins inside.",
                style: AppFont.reguler14.copyWith(color: AppColor.grayColor),
              ),
              24.0.height,
              Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  spacing: 16.h,
                  runSpacing: 8.h,
                  direction: Axis.horizontal,
                  children: [
                    cardPniomoni(
                      number: 1,
                    ),
                    cardPniomoni(
                      number: 2,
                    ),
                    cardPniomoni(
                      number: 3,
                    ),
                    cardPniomoni(
                      number: 4,
                    ),
                    cardPniomoni(
                      number: 5,
                    ),
                    cardPniomoni(
                      number: 6,
                    ),
                    cardPniomoni(
                      number: 7,
                    ),
                    cardPniomoni(
                      number: 8,
                    ),
                    cardPniomoni(
                      number: 9,
                    ),
                    cardPniomoni(
                      number: 10,
                    ),
                    cardPniomoni(
                      number: 11,
                    ),
                    cardPniomoni(
                      number: 12,
                    ),
                  ]),
              PrimaryButton(
                title: 'Continue',
                disable: true,
                loading: false,
                onPressed: () {},
                margin: EdgeInsets.symmetric(vertical: 36.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
