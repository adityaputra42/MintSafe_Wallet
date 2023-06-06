import 'package:flutter/material.dart';
import 'package:mintsafe_wallet/view/widget/empty.dart';

class InfoToken extends StatelessWidget {
  const InfoToken({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Empty(title: "No Data"));
  }
}
