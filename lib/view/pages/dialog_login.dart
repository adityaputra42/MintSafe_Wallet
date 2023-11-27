import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../widget/widget.dart';

class DialogLogin extends StatelessWidget {
  const DialogLogin({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
     padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello",
                style: AppFont.reguler14.copyWith(
                  color:AppColor.grayColor
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Wellcome Back!",
                style: AppFont.medium16.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      var w;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppImage.ilustrasi6,
            width: 120.w,
            fit: BoxFit.cover,
          ),
          8.0.height,
          Text(
            'your session has expired, please enter your password to access this wallet',
            style: AppFont.reguler14.copyWith(
              color: Theme.of(context).indicatorColor,
            ),
            textAlign: TextAlign.center,
          ),
          16.0.height,
          InputText(
            title: 'Password',
            hintText: "Enter your password",
            obscureText: true,
            icon: Icon(
              Icons.visibility_outlined,
              size: 20.w,
            ),
          ),
          32.0.height,
          PrimaryButton(
            title: "Confirm",
            onPressed: () {},
          )
        ],
      );
    }

    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      titlePadding: EdgeInsets.zero,
      title: header(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: content(),
    );
  }
}
