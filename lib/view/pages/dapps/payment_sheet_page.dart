// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/dapps/utils.dart';
import 'package:mintsafe_wallet/view/widget/primary_button.dart';
import 'package:mintsafe_wallet/view/widget/secondary_button.dart';

import '../../../domain/controller/evm_new_controller.dart';

class PaymentSheetText {
  String? title;
  TextStyle? titleStyle;
  String? content;
  TextStyle? contentStyle;

  PaymentSheetText({
    this.title,
    this.content,
    this.contentStyle,
    this.titleStyle,
  });
}

class PaymentSheet extends StatefulWidget {
  PaymentSheet(
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

  final List<PaymentSheetText> datas;
  final VoidCallback nextAction;
  final VoidCallback cancelAction;
  final String amount;
  final bool isSignMsg;
  final String msg;
  final String? estimateGas;
  final String? host;
  final String? favicon;

  @override
  _PaymentSheetState createState() => _PaymentSheetState();

  static List<PaymentSheetText> getTransStyleList(
      {String from = "", String to = "", String remark = "", String fee = ""}) {
    List<PaymentSheetText> datas = [
      PaymentSheetText(
        title: "Payment address",
        content: from,
      ),
      PaymentSheetText(
        title: "Receive address",
        content: to,
      ),
      PaymentSheetText(
        title: "Fee",
        content: fee,
      ),
      PaymentSheetText(
        title: "Remark",
        content: remark,
      )
    ];
    return datas;
  }
}

class _PaymentSheetState extends State<PaymentSheet> {
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
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          children: [
            Center(
              child: Text(
                'Contract Confirmation',
                style: AppFont.semibold16.copyWith(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
              decoration: BoxDecoration(
                color: AppColor.yellowColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 40.w,
                    color: AppColor.yellowColor,
                  ),
                  16.0.width,
                  Flexible(
                    child: Text(
                      'Make sure you trust this site. By interacting with it, you allow this site to access your funds.',
                      style: AppFont.reguler12.copyWith(
                        color: AppColor.yellowColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: const BoxDecoration(color: AppColor.bgDark),
              child: Row(
                children: [
                  Image.asset(
                    evm.selectedChain.value.logo ?? '',
                    width: 40.w,
                  ),
                  8.0.width,
                  Flexible(
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
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Theme.of(context).highlightColor,
                ),
                child: Column(
                  children: [
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
                  ],
                ),
              ),
            ),
            24.0.height,
            Row(
              children: [
                Flexible(
                  child: SecondaryButton(
                    title: 'Cancel',
                    onPressed: sheetClose,
                  ),
                ),
                8.0.width,
                Flexible(
                  child: PrimaryButton(
                    title: widget.isSignMsg ? "Sign" : "Confirm",
                    onPressed: _next,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    // return Container(
    //   height: ScreenUtil().screenHeight / 2,
    //   color: Theme.of(context).backgroundColor,
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           padding: const EdgeInsets.only(
    //             left: 16,
    //             right: 16,
    //             bottom: 20,
    //           ),
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.symmetric(vertical: 12),
    //                 child: Text(
    //                   widget.isSignMsg
    //                       ? "Signature Request"
    //                       : "Contract Interaction",
    //                   style: AppFont.medium12
    //                       .copyWith(color: Theme.of(context).indicatorColor),
    //                 ),
    //               ),
    //               widget.isSignMsg
    //                   ? Container(
    //                       alignment: Alignment.center,
    //                       padding: const EdgeInsets.symmetric(vertical: 12),
    //                       child: Text(
    //                         "Only sign this message if you fully understand the content and trust the requesting site.",
    //                         textAlign: TextAlign.center,
    //                         style: AppFont.medium12.copyWith(
    //                             color: Theme.of(context).indicatorColor),
    //                       ),
    //                     )
    //                   : Container(
    //                       alignment: Alignment.center,
    //                       padding: const EdgeInsets.symmetric(vertical: 12),
    //                       child: Text(
    //                         widget.amount,
    //                         textAlign: TextAlign.center,
    //                         style: AppFont.medium24.copyWith(
    //                             color: Theme.of(context).indicatorColor),
    //                       ),
    //                     ),
    //               widget.isSignMsg
    //                   ? Container(
    //                       padding: EdgeInsets.all(12),
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(12),
    //                           border: Border.all(
    //                               color: Theme.of(context).hintColor)),
    //                       child: Text("Message : ${widget.msg}"))
    //                   : Expanded(
    //                       child: ListView.builder(
    //                         itemCount: widget.datas.length,
    //                         itemBuilder: (BuildContext context, int index) {
    //                           PaymentSheetText sheet = widget.datas[index];
    //                           return Container(
    //                             padding:
    //                                 const EdgeInsets.symmetric(vertical: 8),
    //                             constraints: const BoxConstraints(
    //                               minHeight: 45,
    //                             ),
    //                             decoration: const BoxDecoration(
    //                                 border: Border(
    //                                     bottom: BorderSide(
    //                               width: 0.5,
    //                               color: ColorUtils.lineColor,
    //                             ))),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    //                                 Container(
    //                                   width: 120,
    //                                   child: Text(sheet.title!,
    //                                       style: AppFont.reguler12.copyWith(
    //                                           color: Theme.of(context)
    //                                               .indicatorColor)),
    //                                 ),
    //                                 Expanded(
    //                                   child: Container(
    //                                     alignment: Alignment.centerRight,
    //                                     child: Text(sheet.content!,
    //                                         textAlign: TextAlign.right,
    //                                         style: AppFont.medium12.copyWith(
    //                                             color: Theme.of(context)
    //                                                 .indicatorColor)),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     ),

    //               widget.isSignMsg ? const Spacer() : const SizedBox(),
    //               WidgetButton(
    //                 title: widget.isSignMsg ? "Sign" : "Submit",
    //                 onTap: _next,
    //                 height: 48,
    //                 isDark: themeController.darkTheme,
    //               )
    //               // NextButton(
    //               //   onPressed: _next,
    //               //   borderRadius: 12,
    //               //   height: 48,
    //               //   bgc: ColorUtils.blueColor,
    //               //   title: "OK",
    //               //   textStyle: const TextStyle(
    //               //     fontSize: 16,
    //               //     fontWeight: FontWeightUtils.medium,
    //               //     color: Them,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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
