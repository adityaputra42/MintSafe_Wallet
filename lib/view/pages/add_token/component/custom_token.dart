import 'package:flutter/material.dart';
import 'package:mintsafe_wallet/view/widget/input_text.dart';

class CustomToken extends StatelessWidget {
  const CustomToken({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        children: [
          InputText(title: "Token Address", hintText: "Enter token address"),
          InputText(title: "Token Symbol", hintText: "Enter token symbol"),
          InputText(title: "Decimal", hintText: "Enter decimal"),
        ],
      ),
    );
  }
}
