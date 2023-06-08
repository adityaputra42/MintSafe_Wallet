import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mintsafe_wallet/data/data.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../widget/widget.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.logo,
                width: 140.w,
              ),
              24.0.height,
              Text(
                'MintSafe',
                style: AppFont.semibold24,
              ),
              Text(
                'Unlock the Future of Digital Assets',
                style: AppFont.reguler16,
              ),
              120.0.height,
              SecondaryButton(
                title: "Create a New Wallet",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateNewWalletPage(),
                      ));
                },
              ),
              16.0.height,
              PrimaryButton(
                title: "Import an Existing Wallet",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImportWalletPage(),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
