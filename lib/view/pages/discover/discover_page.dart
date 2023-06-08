import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppGradient.background,
      appBar: WidgetHelper.appBar(
          title: Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              "Discover",
              style: AppFont.semibold20,
            ),
          )),
     
    );
  }
}