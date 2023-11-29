// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/dapps/utils.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:mintsafe_wallet/view/widget/secondary_button.dart';
import 'package:mintsafe_wallet/view/widget/warning.dart';

import '../../../domain/controller/evm_new_controller.dart';

class PaymentDialogText {
  String? title;
  TextStyle? titleStyle;
  String? content;
  TextStyle? contentStyle;

  PaymentDialogText({
    this.title,
    this.content,
    this.contentStyle,
    this.titleStyle,
  });
}

class PaymentDialog extends StatefulWidget {
  const PaymentDialog(
      {Key? key,
      required this.datas,
      required this.nextAction,
      required this.amount,
      required this.cancelAction,
      this.host,
      this.isSignMsg = false,
      this.estimateGas,
      this.favicon,
      this.msg = ""})
      : super(key: key);

  final List<PaymentDialogText> datas;
  final VoidCallback nextAction;
  final VoidCallback cancelAction;
  final String amount;
  final bool isSignMsg;
  final String msg;
  final String? estimateGas;
  final String? host;
  final String? favicon;

  @override
  _PaymentDialogState createState() => _PaymentDialogState();

  static List<PaymentDialogText> getTransStyleList(
      {String from = "", String to = "", String remark = "", String fee = ""}) {
    List<PaymentDialogText> datas = [
      PaymentDialogText(
        title: "Payment address",
        content: from,
      ),
      PaymentDialogText(
        title: "Receive address",
        content: to,
      ),
      PaymentDialogText(
        title: "Fee",
        content: fee,
      ),
      PaymentDialogText(
        title: "Remark",
        content: remark,
      )
    ];
    return datas;
  }
}

class _PaymentDialogState extends State<PaymentDialog> {
  void _next() {
    Navigator.pop(context);
    widget.nextAction();
  }

  void sheetClose() {
    Navigator.pop(context);
    widget.cancelAction();
  }

  EvmNewController evm = Get.find();

  Widget _getTitle() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0.5,
        color: ColorUtils.lineColor,
      ))),
      child: Text(
        "Confirm Transfer",
        style: TextStyle(
            color: ColorUtils.fromHex("#FF000000"),
            fontSize: 16,
            fontWeight: FontWeightUtils.semiBold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Center(
            child: Text(
              'Contract Confirmation',
              style: AppFont.medium16.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    Widget content() {
      return SizedBox(
        width: 900.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Warning(
              warning:
                  'Make sure you trust this site. By interacting with it, you allow this site to access your funds.',
            ),
            16.0.height,
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context).cardColor),
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
                            color: Colors.transparent,
                            child: Image.asset(
                              evm.selectedChain.value.logo ?? '',
                            ))),
                  ),
                  8.0.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isSignMsg
                              ? "Signature Request"
                              : "Contract Interaction",
                          style: AppFont.semibold14.copyWith(
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                        16.0.width,
                        Text(
                          widget.host ?? "",
                          style: AppFont.medium12.copyWith(
                            color: AppColor.grayColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            8.0.height,
            itemRow(
              context,
              title: 'Wallet',
              image: evm.selectedChain.value.logo,
              subtitle:
                  '${evm.selectedAddress.value.name} ${evm.selectedAddress.value.id}',
              subStyle: AppFont.semibold12.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
            ),
            8.0.height,
            itemRow(
              context,
              title: 'Authorized Network',
              image: evm.selectedChain.value.logo,
              subtitle: "${evm.selectedChain.value.name}",
              subStyle: AppFont.semibold12.copyWith(
                color: Theme.of(context).indicatorColor,
              ),
            ),
            8.0.height,
            itemRow(context,
                title: 'Estimated Gas Fee',
                subtitle: widget.estimateGas != null
                    ? "${widget.estimateGas} ${evm.selectedChain.value.symbol}"
                    : "-"),
            // 8.0.height,
            // itemRow(context, title: 'Nonce', subtitle: '53'),
            8.0.height,
            !widget.isSignMsg
                ? const SizedBox()
                : itemRow(
                    context,
                    title: 'Meta Data',
                    subtitle: widget.msg,
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
            32.0.height,
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    title: 'Cancel',
                    onPressed: sheetClose,
                    height: 48,
                  ),
                ),
                8.0.width,
                Expanded(
                  child: PrimaryButton(
                    title: widget.isSignMsg ? "Sign" : "Confirm",
                    onPressed: _next,
                    height: 48,
                  ),
                ),
              ],
            )
          ],
        ),
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

Widget itemRow(
  BuildContext context, {
  required String title,
  String? image,
  required String subtitle,
  TextStyle? subStyle,
  Widget? icon,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: AppFont.medium12.copyWith(
          color: AppColor.grayColor,
        ),
      ),
      image != null
          ? Row(
              children: [
                Image.asset(
                  image,
                  width: 20.w,
                ),
                4.0.width,
                Text(
                  subtitle,
                  style: subStyle ??
                      AppFont.medium12.copyWith(
                        color: Theme.of(context).indicatorColor,
                      ),
                ),
              ],
            )
          : icon != null
              ? Row(
                  children: [
                    Text(
                      subtitle,
                      style: subStyle ??
                          AppFont.medium12.copyWith(
                            color: Theme.of(context).indicatorColor,
                          ),
                    ),
                    4.0.width,
                    icon,
                  ],
                )
              : Text(
                  subtitle,
                  style: subStyle ??
                      AppFont.medium12.copyWith(
                        color: Theme.of(context).indicatorColor,
                      ),
                ),
    ],
  );
}

Widget itemCoin(BuildContext context) {
  return Column(
    children: [
      Image.asset(
        AppImage.eth,
        width: 40.w,
      ),
      8.0.height,
      RichText(
        text: TextSpan(
          text: "BeOne ",
          children: [
            TextSpan(
                text: "(\$SUI)",
                style: AppFont.medium14.copyWith(color: AppColor.grayColor))
          ],
          style: AppFont.medium14.copyWith(
            color: Theme.of(context).indicatorColor,
          ),
        ),
      ),
    ],
  );
}
