import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/confirm_sheed_pharse.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/create_password.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/sheed_pharse.dart';
import 'package:mintsafe_wallet/view/pages/create_new_wallet/component/stepper.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

final stepProvider = StateProvider<int>((ref) => 0);

class CreateNewWalletPage extends ConsumerWidget {
  const CreateNewWalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var indexStep = ref.watch(stepProvider);
    Widget body() { 
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.0.height,
            const StepperCustom(),
            24.0.height,
            indexStep == 0
                ? const CreatePassword()
                : indexStep == 1
                    ? const SheedPharse()
                    : ConfirmSheedPharse()
          ],
        );
      
    }

    return Scaffold(
      backgroundColor: AppColor.bgDark,
      appBar: WidgetHelper.appBar(
          title: Row(
        children: [
          GestureDetector(
            onTap: () {
              ref.read(stepProvider.notifier).state = 0;
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textDark,
              size: 24.h,
            ),
          ),
          16.0.width,
          Text(
            "Create a New Wallet",
            style: AppFont.medium16.copyWith(color: AppColor.textDark),
          ),
        ],
      )),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: body(),
          ),
        ),
      ),
    );
  }
}
