import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintsafe_wallet/config/theme/style.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              title: 'MintSafe Wallet',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: Style.themeData(false),
                useMaterial3: true,
              ),
              home: const CreateNewWalletPage());
        });
  }
}
