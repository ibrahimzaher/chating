import 'package:flutter/material.dart';

class CustomSpacer extends StatelessWidget {
  CustomSpacer({Key? key, this.width = 0, this.height = 5}) : super(key: key);
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
