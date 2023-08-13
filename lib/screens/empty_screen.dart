import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        "Nothing To Show".text.headline5(context).make(),
      ],
    );
  }
}
